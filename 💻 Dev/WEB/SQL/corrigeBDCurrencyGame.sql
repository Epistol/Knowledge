CREATE DEFINER=`amedassi`@`%` FUNCTION `identify`(_login varchar(45) , _password varchar(45)) RETURNS int(11)
BEGIN
	declare __nb int ;
	select count(*) into __nb from currencyUser where login=_login and password=md5(_password) and active=1 ;
RETURN __nb;
END

CREATE DEFINER=`anthony`@`%` FUNCTION `exists`(_login varchar(45)) RETURNS int(11)
BEGIN
	declare __nb int ;
	select count(*) into __nb from currencyUser where login=_login  ;
RETURN __nb;
END

CREATE DEFINER=`amedassi`@`%` PROCEDURE `buy`(_currencyUser varchar(45) , _currency char(3) , _qt int)
BEGIN
	declare __instantValue decimal(16,6) ;
    declare __totalValue decimal(16,6) ;
    declare __userMoney decimal(16,6) ;
    declare __nbWallet int ;
    declare __commission float ;
    set __commission = 0.01 ;
	if( _qt > 0 ) then
		select lastValue into __instantValue from currency where `code`=_currency ;
		set __totalValue = _qt/__instantValue ;
		select money into __userMoney from currencyUser where login=_currencyUser;
		
		if( __userMoney >= __totalValue*(1+__commission) ) then
			insert into buy(currencyUser,currency,qt,currencyValue,buyTimestamp) values (_currencyUser,_currency,_qt,__instantValue,now()) ;
			update currencyUser set money=money - __totalValue*(1+__commission)  where login=_currencyUser;
			select count(*) into __nbWallet from wallet where currencyUser=_currencyUser and currency=_currency ;
			if( __nbWallet != 0 ) then
				update wallet set qt = qt+_qt where currencyUser=_currencyUser and currency=_currency  ;
			else
				insert into wallet(currencyUser,currency,qt) values (_currencyUser,_currency,_qt) ;
			end if ;
		else
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Not enough Money';
		end if ;
	end if ;
END

CREATE DEFINER=`amedassi`@`%` PROCEDURE `sale`(_currencyUser varchar(45) , _currency char(3) , _qt int)
BEGIN
	declare __instantValue decimal(16,6) ;
    declare __totalValue decimal(16,6) ;
    declare __userMoney decimal(16,6) ;
    declare __walletQt int ;
	declare __commission float ;
    set __commission = 0.01 ;
    if( _qt > 0 ) then
		select lastValue into __instantValue from currency where `code`=_currency ;
		set __totalValue = _qt/__instantValue ;
		select money into __userMoney from currencyUser where login=_currencyUser;
		select qt into __walletQt from wallet where currencyUser=_currencyUser and currency=_currency ;
		if( __walletQt > _qt ) then
			insert into sale(currencyUser,currency,qt,currencyValue,saleTimestamp) values (_currencyUser,_currency,_qt,__instantValue,now()) ;
			update currencyUser set money=money + __totalValue*(1-__commission) where login=_currencyUser;
			update wallet set qt = qt-_qt where currencyUser=_currencyUser and currency=_currency  ;       
		elseif ( __walletQt = _qt ) then
			insert into sale(currencyUser,currency,qt,currencyValue,saleTimestamp) values (_currencyUser,_currency,_qt,__instantValue,now()) ;
			update currencyUser set money=money + __totalValue*(1-__commission)  where login=_currencyUser;
			delete from wallet where currencyUser=_currencyUser and currency=_currency  ;   
		else
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Not enough currency';
		end if ;
    end if ;
END

CREATE DEFINER=`amedassi`@`%` TRIGGER `currencies`.`currency_BEFORE_UPDATE`
BEFORE UPDATE ON `currencies`.`currency`
FOR EACH ROW
BEGIN
	insert into quote(currency,`value`,updated) values (NEW.code,OLD.lastValue,OLD.lastUpdate) ;
END

CREATE DEFINER=`amedassi`@`%` PROCEDURE `getQuoteHistory`(_currency char(3))
BEGIN
	select currency , name , value , updated   from quote inner join currency on currency.code = quote.currency where currency= _currency order by updated asc ;
END

CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `amedassi`@`%` 
    SQL SECURITY DEFINER
VIEW `currencies`.`score` AS
    SELECT 
        `currencies`.`currencyUser`.`firstname` AS `firstname`,
        `currencies`.`currencyUser`.`lastname` AS `lastname`,
        `currencies`.`currencyUser`.`money` AS `money`,
        `currencies`.`currencyUser`.`login` AS `login`,
        `currencies`.`currencyUser`.`photo` AS `photo`,
        SUM(((`currencies`.`wallet`.`qt` * 1) / `currencies`.`currency`.`lastValue`)) AS `walletValue`,
        (SUM(((`currencies`.`wallet`.`qt` * 1) / `currencies`.`currency`.`lastValue`)) + `currencies`.`currencyUser`.`money`) AS `totalValue`
    FROM
        ((`currencies`.`wallet`
        JOIN `currencies`.`currency` ON ((`currencies`.`wallet`.`currency` = `currencies`.`currency`.`code`)))
        JOIN `currencies`.`currencyUser` ON ((`currencies`.`currencyUser`.`login` = `currencies`.`wallet`.`currencyUser`)))
    GROUP BY `currencies`.`currencyUser`.`login`
	
CREATE DEFINER=`amedassi`@`%` PROCEDURE `getQuotesStats`()
BEGIN
select currency , (select name from currency where `code`= currency ) as nameC , (select  lastValue as lastCValue from currency where `code`= currency ) as lastCValue,
                min(value) as minCValue , max(value) as maxCValue ,avg(value)  as avgCValue 
                from quote 
                group by currency ; 
END

