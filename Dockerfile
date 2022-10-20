FROM python:3.10-alpine as builder

# Install build-base to allow for compilation of the profiling agent.
RUN apk add --update --no-cache build-base git

# Compile the profiling agent, generating wheels for it.
COPY ./requirements.txt .
RUN pip3 wheel --wheel-dir=/tmp/wheels -r requirements.txt

FROM python:3.10-alpine

# Copy over the directory containing wheels for the profiling agent.
COPY --from=builder /tmp/wheels /tmp/wheels

RUN apk add --update --no-cache libgcc git

# Install the profiling agent.
COPY ./requirements.txt .
RUN pip3 install --no-index --find-links=/tmp/wheels -r requirements.txt

RUN pip3 freeze

COPY ./main.py .

# Run the application when the docker image is run, using either CMD (as is done
# here) or ENTRYPOINT.
CMD python3 -u main.py
