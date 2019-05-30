# Docker container for PHPQATools

## Introduction

This image includes
* PHPUnit
* PHP-Invoker
* DbUnit
* PHPLOC
* PHPCPD
* PHP_Depend
* PHPMD
* PHP_CodeSniffer
* Fabien Potencier/PHP Coding Standards Fixer
* Sensiolabs/Security-Checker
* Behat
* PHPStan

## Usage

1. Build the image first: `docker build -t phpqatools .`
1. `cd` to your project and run `docker run --rm -v $(pwd):/app --env LOCAL_USER_ID=$(id -u) phpqatools phpcs`