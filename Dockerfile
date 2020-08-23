FROM alpine

WORKDIR /etc/cryptme_workdir

ARG CRYPTME_EXECUTABLE

RUN echo $CRYPTME_EXECUTABLE

COPY $CRYPTME_EXECUTABLE the_executable

CMD ./the_executable