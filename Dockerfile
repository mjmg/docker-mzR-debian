## start with the Docker 'base R' Debian-based image
FROM r-base:latest

## Remain current
RUN apt-get update -qq \
	&& apt-get dist-upgrade -y

RUN apt-get update -qq \
	&& apt-get install  -y  \
    		curl \
    		netcdf-bin \
		libnetcdf-dev \
		libxml2-dev \
		libssl-dev
	
# Setup default cran repo
RUN echo "r <- getOption('repos'); r['CRAN'] <- 'http://cran.us.r-project.org'; options(repos = r);" > ~/.Rprofile

# This installs other R packages under Bioconductor
# RUN Rscript -e "source('https://bioconductor.org/biocLite.R'); biocLite('mzR')"
RUN Rscript -e "source('http://bioconductor.org/biocLite.R'); biocLite('devtools'); library(devtools); install_github('sneumann/mzR', branch='boost_159', repos=biocinstallRepos())"



