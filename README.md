# Dogen

Documents generator for bash

## Installation

    $ gem install dogen

## Usage

    $ dogen --help

### Setup repository directory

    $ mkdir /home/user/Dropbox/dogen
    $ dogen c --repository path::/home/user/Dropbox/dogen

### Generate documet

create document like (vcard.erb) in yours repository directory: 

```
BEGIN:VCARD
VERSION:2.1
N:<%= data['first_name'] %>;<%= data['last_name'] %>
FN:<%= data['first_name'] %> <%= data['last_name'] %>
ORG:<%= data['org'] %>
TITLE:<%= data['title'] %>
PHOTO;GIF:<%= data['photo'] %>
TEL;WORK;VOICE:<%= data['home_tel'] %>
TEL;HOME;VOICE:<%= data['work_tel'] %>
ADR;WORK:;;<%= data['streat'] %>;<%= data['province'] %>;<%= data['state'] %>;<%= data['postcode'] %>;<%= data['country']
LABEL;WORK;ENCODING=QUOTED-PRINTABLE:<%= data['streat'] %>=0D=0A<%= data['province'] %>, <%= data['state'] %> <%= data['postcode'] %>=0D=0A<%= data['country']
ADR;HOME:;;42 Plantation St.;<%= data['province'] %>;<%= data['state'] %>;<%= data['postcode'] %>;<%= data['country']
LABEL;HOME;ENCODING=QUOTED-PRINTABLE:
EMAIL;PREF;INTERNET:<%= data['email'] %>
REV:20080424T195243Z
END:VCARD

```

and use command

    $ dogen g vcard first_name:Pawel last_name:Niemczyk org:MyCompany title:Mr

or prepare json with the data and use command:

    $ dogen g vcard -j /home/user/tmp/my_vcard.json


you can use patials inside any erb templates like:

```

Your vcard source for <%= data['first_name'] %> <%= data['last_name'] %> :
<%= render('vcard') %>

```

### You can use it to any type of file

## Contributing

1. Fork it ( https://github.com/[my-github-username]/dogen/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
