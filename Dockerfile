FROM python:3.6-alpine
COPY . /code
WORKDIR /code
RUN pip install -r requirements.txt
CMD ["python", "flask/app.py"]
