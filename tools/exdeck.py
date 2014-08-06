import json
import urllib
obj  = json.load(open("AllSets.json"))
seq={ 'name', 'rarity', 'cost', 'health', 'attack', 'playerClass'}
out=[]

for i in xrange(len(obj["Basic"])):
	if obj["Basic"][i].has_key("collectible") and  obj["Basic"][i]["type"]!="Hero":
		out.append(obj["Basic"][i])

for i in xrange(len(obj["Reward"])):
	if obj["Reward"][i].has_key("collectible")and obj["Reward"][i]["collectible"]==True:
		out.append(obj["Reward"][i])

for i in xrange(len(obj["Promotion"])):
	if obj["Promotion"][i].has_key("collectible")and obj["Promotion"][i]["collectible"]==True:
		out.append(obj["Promotion"][i])

for i in xrange(len(obj["Curse of Naxxramas"])):
	if obj["Curse of Naxxramas"][i].has_key("collectible")and obj["Curse of Naxxramas"][i]["collectible"]==True:
		out.append(obj["Curse of Naxxramas"][i])

for i in xrange(len(obj["Expert"])):
	if obj["Expert"][i].has_key("collectible") and obj["Expert"][i]["collectible"]==True:
		out.append(obj["Expert"][i])

for card in out:
	print card["id"]
	#urllib.urlretrieve ("http://wow.zamimg.com/images/hearthstone/cards/enus/original/"+card["id"]+".png", "cards/"+card["id"]+".png")


print len(out)
f = open('cards/1.json', 'w')
f.write(json.dumps(out))
f.close()
#print json.dumps(out,indent=4)
