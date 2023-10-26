FROM rocker/tidyverse:4.3.1
RUN install2.r --error kableExtra

COPY . /home/docker
WORKDIR "/home/docker"
CMD ["Rscript", "code.R"]
