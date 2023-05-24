ARG R_VERSION
FROM rocker/r-ver:${R_VERSION}

## Install dependencies
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    pandoc \
    curl \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libfontconfig1-dev \
    libxt6 \
    libcairo2-dev \
    libv8-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    libfreetype6-dev \
    libpng-dev \
    libtiff5-dev \
    libjpeg-dev

## Quarto
WORKDIR /home
ARG QUARTO_VERSION
RUN curl -o quarto.deb -L https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-amd64.deb
RUN apt install ./quarto.deb
RUN rm quarto.deb
RUN quarto install tool tinytex

## RENV
ARG RENV_VERSION
RUN R -e "install.packages('remotes', repos = c(CRAN = 'https://cloud.r-project.org'))"
RUN R -e "remotes::install_github('rstudio/renv@${RENV_VERSION}')"
COPY renv.lock renv.lock
RUN mkdir -p renv
COPY .Rprofile .Rprofile
COPY renv/activate.R renv/activate.R
COPY renv/settings.json renv/settings.json
RUN R -e 'renv::restore()'