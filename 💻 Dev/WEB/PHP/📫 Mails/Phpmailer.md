![PHPMailer](https://raw.github.com/PHPMailer/PHPMailer/master/examples/images/phpmailer.png)

# PHPMailer - Une class d'envoi de mail en php


## Composants

- Le plus populaire et actif au monde
- Utilisé par beaucoup de projet open-source: WordPress, Drupal, 1CRM, SugarCRM, Yii, Joomla! and many more
- Support SMTP (sans local)
- Une doc et des maj régulièrement à jour

## License [EN]

This software is distributed under the [LGPL 2.1](http://www.gnu.org/licenses/lgpl-2.1.html) license. Please read LICENSE for information on the
software availability and distribution.

## Installation & chargement

PHPMailer est disponible via [Composer/Packagist](https://packagist.org/packages/phpmailer/phpmailer) (using semantic versioning), so just add this line to your `composer.json` file:

```json
"phpmailer/phpmailer": "~5.2"
```

ou

```sh
composer require phpmailer/phpmailer
```
Si vous utilisez Gmail XOAUTH 2, vous aurez besoin du package `league/oauth2-client`.

### Minimal installation

While installing the entire package manually or with composer is simple, convenient and reliable, you may want to include only vital files in your project. At the very least you will need [class.phpmailer.php](https://github.com/PHPMailer/PHPMailer/tree/master/class.phpmailer.php). If you're using SMTP, you'll need [class.smtp.php](https://github.com/PHPMailer/PHPMailer/tree/master/class.smtp.php), and if you're using POP-before SMTP, you'll need [class.pop3.php](https://github.com/PHPMailer/PHPMailer/tree/master/class.pop3.php). For all of these, we recommend you use [the autoloader](https://github.com/PHPMailer/PHPMailer/tree/master/PHPMailerAutoload.php) too as otherwise you will either have to `require` all classes manually or use some other autoloader. You can skip the [language](https://github.com/PHPMailer/PHPMailer/tree/master/language/) folder if you're not showing errors to users and can make do with English-only errors. You may need the additional classes in the [extras](extras/) folder if you are using those features, including NTLM authentication and ics generation. If you're using Google XOAUTH2 you will need `class.phpmaileroauth.php` and `class.oauth.php` classes too, as well as the composer dependencies.

## Maildev & PHPMailer 

Il suffit de mettre le port 1025 écouté par Maildev en local.
```
 $mail = new PHPMailer;
        $mail->Port = 1025;
        $mail->isHTML(true);
```
/!\ Tout le reste est en anglais (pas par flemme de traduire (lol) mais parce que la version n'a pas besoin d'être traduite (si vous faites du développement, vous devez avoir des bases d'anglais ! ) ).
## A Simple Example

```php
<?php
require 'PHPMailerAutoload.php';

$mail = new PHPMailer;

//$mail->SMTPDebug = 3;                               // Enable verbose debug output

$mail->isSMTP();                                      // Set mailer to use SMTP
$mail->Host = 'smtp1.example.com;smtp2.example.com';  // Specify main and backup SMTP servers
$mail->SMTPAuth = true;                               // Enable SMTP authentication
$mail->Username = 'user@example.com';                 // SMTP username
$mail->Password = 'secret';                           // SMTP password
$mail->SMTPSecure = 'tls';                            // Enable TLS encryption, `ssl` also accepted
$mail->Port = 587;                                    // TCP port to connect to

$mail->setFrom('from@example.com', 'Mailer');
$mail->addAddress('joe@example.net', 'Joe User');     // Add a recipient
$mail->addAddress('ellen@example.com');               // Name is optional
$mail->addReplyTo('info@example.com', 'Information');
$mail->addCC('cc@example.com');
$mail->addBCC('bcc@example.com');

$mail->addAttachment('/var/tmp/file.tar.gz');         // Add attachments
$mail->addAttachment('/tmp/image.jpg', 'new.jpg');    // Optional name
$mail->isHTML(true);                                  // Set email format to HTML

$mail->Subject = 'Here is the subject';
$mail->Body    = 'This is the HTML message body <b>in bold!</b>';
$mail->AltBody = 'This is the body in plain text for non-HTML mail clients';

if(!$mail->send()) {
    echo 'Message could not be sent.';
    echo 'Mailer Error: ' . $mail->ErrorInfo;
} else {
    echo 'Message has been sent';
}
```

You'll find plenty more to play with in the [examples](https://github.com/PHPMailer/PHPMailer/tree/master/examples) folder.

That's it. You should now be ready to use PHPMailer!

## Localization
PHPMailer defaults to English, but in the [language](https://github.com/PHPMailer/PHPMailer/tree/master/language/) folder you'll find numerous (46 at the time of writing!) translations for PHPMailer error messages that you may encounter. Their filenames contain [ISO 639-1](http://en.wikipedia.org/wiki/ISO_639-1) language code for the translations, for example `fr` for French. To specify a language, you need to tell PHPMailer which one to use, like this:

```php
// To load the French version
$mail->setLanguage('fr', '/optional/path/to/language/directory/');
```

We welcome corrections and new languages - if you're looking for corrections to do, run the [phpmailerLangTest.php](https://github.com/PHPMailer/PHPMailer/tree/master/test/phpmailerLangTest.php) script in the tests folder and it will show any missing translations.

## Documentation

Examples of how to use PHPMailer for common scenarios can be found in the [examples](https://github.com/PHPMailer/PHPMailer/tree/master/examples) folder. If you're looking for a good starting point, we recommend you start with [the Gmail example](https://github.com/PHPMailer/PHPMailer/tree/master/examples/gmail.phps).

There are tips and a troubleshooting guide in the [GitHub wiki](https://github.com/PHPMailer/PHPMailer/wiki). If you're having trouble, this should be the first place you look as it's the most frequently updated.

Complete generated API documentation is [available online](http://phpmailer.github.io/PHPMailer/).

You'll find some basic user-level docs in the [docs](docs/) folder, and you can generate complete API-level documentation using the [generatedocs.sh](https://github.com/PHPMailer/PHPMailer/tree/master/docs/generatedocs.sh) shell script in the docs folder, though you'll need to install [PHPDocumentor](http://www.phpdoc.org) first. You may find [the unit tests](https://github.com/PHPMailer/PHPMailer/tree/master/test/phpmailerTest.php) a good source of how to do various operations such as encryption.

If the documentation doesn't cover what you need, search the [many questions on Stack Overflow](http://stackoverflow.com/questions/tagged/phpmailer), and before you ask a question about "SMTP Error: Could not connect to SMTP host.", [read the troubleshooting guide](https://github.com/PHPMailer/PHPMailer/wiki/Troubleshooting).

## Tests

There is a PHPUnit test script in the [test](https://github.com/PHPMailer/PHPMailer/tree/master/test/) folder.

Build status: [![Build Status](https://travis-ci.org/PHPMailer/PHPMailer.svg)](https://travis-ci.org/PHPMailer/PHPMailer)

If this isn't passing, is there something you can do to help?

## Security

Please disclose any vulnerabilities found responsibly - report any security problems found to the maintainers privately.

PHPMailer versions prior to 5.2.20 (released December 28th 2016) are vulnerable to [CVE-2016-10045](https://web.nvd.nist.gov/view/vuln/detail?vulnId=CVE-2016-10045) a remote code execution vulnerability, responsibly reported by [Dawid Golunski](https://legalhackers.com/advisories/PHPMailer-Exploit-Remote-Code-Exec-CVE-2016-10045-Vuln-Patch-Bypass.html), and patched by Paul Buonopane (@Zenexer).

PHPMailer versions prior to 5.2.18 (released December 2016) are vulnerable to [CVE-2016-10033](https://web.nvd.nist.gov/view/vuln/detail?vulnId=CVE-2016-10033) a critical remote code execution vulnerability, responsibly reported by [Dawid Golunski](http://legalhackers.com/advisories/PHPMailer-Exploit-Remote-Code-Exec-CVE-2016-10033-Vuln.html).

See [SECURITY](https://github.com/PHPMailer/PHPMailer/tree/master/SECURITY.md) for more detail on security issues.
