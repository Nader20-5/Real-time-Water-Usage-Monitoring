import csv
import time
from kafka import KafkaProducer
import json

producer = KafkaProducer(
    bootstrap_servers=['localhost:9092'],
    value_serializer=lambda v: json.dumps(v).encode('utf-8')
)

with open('water_usage_not_clean.csv' , newline='') as csvFile:
    reader = csv.DictReader(csvFile)
    for row in reader:
        print(
            row['timestamp'],
            row['device'],
            row['flow_rate_lpm'],
            row['pressure_bar'],
            row['total_usage_liters']
        )
        producer.send("raw_water_data", value=row)
        time.sleep(3)

producer.flush()
