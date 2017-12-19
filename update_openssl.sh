## Navigate to src directory
cd /usr/src

# Download Latest one from openssl.org
wget https://www.openssl.org/source/openssl-1.0.2-latest.tar.gz

# Untar the src file
tar -zxf openssl-1.0.2-latest.tar.gz

cd openssl-1.0.2*
./config
make
make test
make install

# Take Backup of old bin file
mv /usr/bin/openssl /root/
# Create link of latest openssl
ln -s /usr/local/ssl/bin/openssl /usr/bin/openssl

# Check version
echo  openssl version
