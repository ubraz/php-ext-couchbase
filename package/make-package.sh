#!/bin/sh -ex
# creates a tar.gz file with a PHP extension
# depends on libcouchbase and PHP > 5.3.6 being installed
#
# Usage ./package/make-package.sh
# Creates ./package/php-ext-couchbase.tar.gz

phpize
if [ -z "$1" ]; then
  ./configure
else
  ./configure --with-couchbase=$1
fi
make clean
make

# make test (requires Couchbase Server running)
# make test

# package
cd package
  mkdir -p php-ext-couchbase/example
  cp ../CREDITS \
     ../LICENSE \
     README.md \
     ../example/couchbase-api.php \
     ../example/couchbase.ini \
     ../.libs/couchbase.so \
     php-ext-couchbase

  cp ../example/buckets.php \
     ../example/view.php \
     php-ext-couchbase/example

  tar cf - php-ext-couchbase | gzip -9 - > php-ext-couchbase.tar.gz
  rm -rf php-ext-couchbase
cd ..

# Done
echo "Done"
