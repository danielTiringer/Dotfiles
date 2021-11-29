# Installs eclipse's jdtls

sudo mkdir -p /usr/share/java/jdtls
curl --location https://download.eclipse.org/jdtls/milestones/1.6.0/jdt-language-server-1.6.0-202111261512.tar.gz | tar --extract --gzip --verbose --directory /home/daniel/.local/lib/jdtls
