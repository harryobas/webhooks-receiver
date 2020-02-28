#Introduction

An API-only app that provides a single endpoint for processing webhook requests to enable the integration of a git hosting cloud service with a ticket tracking cloud service. More specifically, the app provides the following:

1. Receives incoming webhooks
2. Parses the incoming webhooks data
3. Stores them to a DB
4. POSTs issue updates to a ticket tracking app

#Installation

This app is dockerized  to enable both ease of installation and execution on either Linux, mac or windows. To install/run on Linux, make sure to have both docker and docker-compose installed on your machine and follow the instructions below:

1. $ git clone https://github.com/harryobas/webhooks-receiver.git
2. $ cd webhooks-receiver
3. $ sudo docker-compose build
4. $ sudo docker-compose up -d

#Endpoint

This app accepts http post request on localhost:3000/hooks  
