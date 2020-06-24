#!/bin/bash

host=10.10.11.65:7872
curl -v -i http://${host}/info/digits -F num=1  -H "contract_id":"D202002059029" -H "product_info":"4" -H 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjbGllbnRJZCI6IjYwMDA2NTc1MSIsImV4cCI6MTU4ODA4NDkxNCwiaXNzcyI6ImZvc2FmZXIuY29tIiwiaWF0IjoxNTgwODg0OTE0fQ.tHXHMOMgX8RC7ET5U13seiw4k4AVFBI6JCCiq1wNCIo'