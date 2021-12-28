## PHP-FPM Image

 **Helpful PHP-FPM image from official ubuntu:xenial**
 >
 > PHP-FPM version - 7.4

 > DateTime - Europe/Kiev

 > Composer installed globally

## Tags
 * solegs/php-fpm7.4:stable

### Extensions:

 * php7.4-pgsql
 * php7.4-mysql
 * php7.4-opcache
 * php7.4-common
 * php7.4-mbstring
 * php7.4-mcrypt
 * php7.4-soap
 * php7.4-cli
 * php7.4-intl
 * php7.4-json
 * php7.4-xsl
 * php7.4-imap
 * php7.4-ldap
 * php7.4-curl
 * php7.4-gd
 * php7.4-dev
 * php7.4-fpm
 * php7.4-redis
 * php7.4-memcached
 * php7.4-mongodb
 * php7.4-bcmath
 * php7.4-imagick (`new`)

### In addition

 * Composer (installed globally)
 
### Docker Compose yml

```yaml
version: "2"
services:
 php-fpm:
   image: solegs/php-fpm7.4
   volumes:
    - .:/usr/local/src/app
   working_dir: /usr/local/src/app
   extra_hosts:
    - "app:127.0.0.1"
```