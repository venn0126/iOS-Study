import requests
import json
import bs4
from time import strftime, sleep
import os


def gmail_dot_gen(username, number):
    emails = list()
    username_length = len(username)
    padding = "{0:0" + str(username_length - 1) + "b}"
    for i in range(0, number):
        bin = padding.format(i)
        full_email = ""

        for j in range(0, username_length - 1):
            full_email += (username[j]);
            if bin[j] == "1":
                full_email += "."
        full_email += (username[j + 1])
        emails.append(full_email + "@itian.club")
    return emails


def register(user_email):
    print(strftime('[%H:%M:%S]:'), "Creating Account...")

    home_url = "https://www.footlocker.co.uk/en/homepage"
    r = requests.Session()
    r.headers.update({
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.66 Safari/537.36'
    })
    x = r.get(home_url).text
    xs = bs4._soup(x, 'html.parser')
    token = ''
    for i in xs.find_all("script", {"type": "text/javascript"}):
        if "SYNCHRONIZER_TOKEN_VALUE =" in str(i):
            t = (str(i)).split("'")
            token = t[3]


    print(token)
    # https://www.footlocker.co.uk/INTERSHOP/web/FLE/Footlocker-Footlocker_GB-Site/en_GB/-/GBP/ViewForgotLoginData-Dispatch
    # reg_url = 'https://www.footlocker.co.uk/INTERSHOP/web/WFS/Footlocker-Footlocker_GB-Site/en_GB/-/GBP/ViewUserAccount-Dispatch'
    # reg_url = 'https://www.footlocker.co.uk/INTERSHOP/web/FLE/Footlocker-Footlocker_GB-Site/en_GB/-/GBP/ViewUserAccount-Dispatch'
    reg_url = 'https://www.footlocker.co.uk/public/2193ac875175a2192040657880dad'

    config_file = open("config.json", "r")
    config = json.load(config_file)
    config_file.close()

    user = {
        'SynchronizerToken': token,
        'Ajax': '1',
        'RegisterUserFullEmail_Login': user_email,
        'RegisterUserFullEmail_Password': config['password'],
        'AddressForm_Address3': '',
        'isshippingaddress': '',
        'AddressForm_LocaleID': 'en_GB',
        'AddressForm_Title': 'common.account.salutation.mr.text',
        'AddressForm_FirstName': config['firstName'],
        'AddressForm_LastName': config['lastName'],
        'AddressForm_Address1': config['street'],
        'AddressForm_Address2': config['houseNo'],
        'AddressForm_City': config['city'],
        'AddressForm_PostalCode': config['postCode'],
        'AddressForm_CountryCode': 'GB',
        'AddressForm_PhoneHome': config['phoneNo'],
        'AddressForm_Birthday_Day': config['birth-day'],
        'AddressForm_Birthday_Month': config['birth-month'],
        'AddressForm_Birthday_Year': config['birth-year'],
        'AddressForm_PreferredShippingAddress': 'true',
        'AddressForm_PreferredBillingAddress': 'true',
        'RegisterUserFullEmail_Newsletter': 'true',
        'CreateAccount': ''
    }

    r.post(reg_url, data=user)

    print(strftime('[%H:%M:%S]:'), "Account Created using", user_email)

    export = user_email + ":" + config['password']
    return export


if __name__ == "__main__":
    # print(os.getcwd())
    config = open('config.json', 'r')
    config = json.load(config)

    no = int(input("How many accounts would you like?: "))

    emails = gmail_dot_gen(config['gmailPrefix'], no)
    accounts = []
    for email in emails:
        account = register(email)
        accounts.append(account)
        sleep(5)

    f = open('accounts.txt', 'w')

    for each in accounts:
        f.write("%s\n" % each)
