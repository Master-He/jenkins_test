FROM python:3.6-alpine
COPY . /code
WORKDIR /code
RUN pip install redis flask
CMD ["python", "flask/app.py"]
