FROM alpine:3.11 AS base
# Python && pip && npm installation
RUN apk add --update python py-pip nodejs npm
WORKDIR /app
COPY ./flask-app/ ./
RUN npm install
RUN npm run build
RUN pip install --target=/app -r requirements.txt

FROM python:2.7-alpine 
COPY --from=base /app /app
WORKDIR /app
COPY ./flask-app/app.py ./app.py
ENTRYPOINT [ "python" ]
CMD [ "app.py" ]


















