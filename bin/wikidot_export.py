from xmlrpc.client import ServerProxy
import json
 
pages = []
wikidot = ServerProxy('https://username:api_key@scpfoundation.ru/xml-rpc-api.php')
 
pages_names = wikidot.pages.select({"site": "scp-ru"})
for page_name in pages_names:
    p = wikidot.pages.get_one( { "site": "scp-ru", "page": page_name } )
    del(p['html'])
    pages.append(p)
    print("Done: %s" % ( page_name ))
 
with open('scp-ru.json', 'w') as outfile:
    json.dump(pages, outfile)
