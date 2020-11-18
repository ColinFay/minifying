FROM rocker/r-ver:3.6.1
RUN apt-get update && apt-get install -y  git-core libcurl4-openssl-dev libssh2-1-dev libssl-dev libxml2-dev make pandoc pandoc-citeproc zlib1g-dev && rm -rf /var/lib/apt/lists/*
RUN echo "options(repos = c(CRAN = 'https://packagemanager.rstudio.com/all/latest'), download.file.method = 'libcurl')" >> /usr/local/lib/R/etc/Rprofile.site
RUN apt-get update && apt-get -y install curl gnupg && curl -sL https://deb.nodesource.com/setup_14.x   | bash - && apt-get -y install nodejs
RUN R -e 'install.packages("remotes")'
RUN Rscript -e 'remotes::install_version("config",upgrade="never", version = "0.3")'
RUN Rscript -e 'remotes::install_version("golem",upgrade="never", version = "0.2.1")'
RUN Rscript -e 'remotes::install_version("shiny",upgrade="never", version = "1.4.0.2")'
RUN Rscript -e 'remotes::install_version("magrittr",upgrade="never", version = "1.5")'
RUN Rscript -e 'remotes::install_version("processx",upgrade="never", version = "3.4.2")'
RUN Rscript -e 'remotes::install_version("attempt",upgrade="never", version = "0.3.1")'
RUN Rscript -e 'remotes::install_version("DT",upgrade="never", version = "0.12")'
RUN Rscript -e 'remotes::install_version("glue",upgrade="never", version = "1.4.0")'
RUN Rscript -e 'remotes::install_version("fs",upgrade="never", version = "1.4.1")'
RUN Rscript -e 'remotes::install_version("withr",upgrade="never", version = "2.2.0")'
RUN Rscript -e 'remotes::install_version("pkgload",upgrade="never", version = "1.0.2")'
RUN Rscript -e 'remotes::install_version("knitr",upgrade="never", version = "1.28")'
RUN Rscript -e 'remotes::install_version("rmarkdown",upgrade="never", version = "2.1")'
RUN Rscript -e 'remotes::install_version("testthat",upgrade="never", version = "2.3.2")'
RUN Rscript -e 'remotes::install_version("httpuv",upgrade="never", version = "1.5.2")'
RUN Rscript -e 'remotes::install_version("pagedown",upgrade="never", version = "0.10")'
RUN Rscript -e 'remotes::install_github("ColinFay/gargoyle@ab4bd5d4f864f12cd7f70a1caa8ebc4b10c0d0e9")'
RUN Rscript -e 'remotes::install_github("rstudio/htmltools@a8025f360d70c67d41610e12f5a9ee6349327060")'
RUN Rscript -e 'remotes::install_github("r-lib/memoise@4aefd9f985f872d85d88461454eb2eb21d732bf7")'
RUN Rscript -e 'remotes::install_github("colinfay/minifyr@b3942aae40055db300dbe2ecea6d34f112688775")'
RUN Rscript -e 'remotes::install_github("r-lib/fastmap@61c609993a40b8101b141b2c940bf8ccbaef4dfa")'
RUN Rscript -e 'remotes::install_github("r-lib/lifecycle@355dcba8530bcce57c15847165ca568f9f81b43e")'
RUN mkdir /build_zone
ADD . /build_zone
WORKDIR /build_zone
RUN R -e 'remotes::install_local(upgrade="never")'

EXPOSE 80
CMD R -e "options('shiny.port'=80,shiny.host='0.0.0.0');minifying::run_app()"
