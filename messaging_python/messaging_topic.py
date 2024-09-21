import firebase_admin
from firebase_admin import messaging

cred_obj = firebase_admin.credentials.Certificate('nemea_creds.json')
firebase_admin.initialize_app(cred_obj)

# The topic name can be optionally prefixed with "/topics/".
topic = 'all'

# See documentation on defining a message payload.
message = messaging.Message(
    data={
        'title': 'proidopoiishsh 1',
        'description': 'egine auto kai ekeino',
    },
    topic=topic,
)

# Send a message to the devices subscribed to the provided topic.
response = messaging.send(message)
# Response is a message ID string.
print('Successfully sent message:', response)
