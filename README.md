# hn_backpack

**THIS IS AN EDIT OF WASABI BACKPACK AND GRN WALLET, DO NOT SELL THIS SCRIPT, IF YOU PAID, YOU WERE SCAMMED!!!**
THIS IS MOSTLY NOT MY CODE, AND I WILL NOT PROVIDE SUPPORT!

# DEPENDENCIES:
ox_inventory
es_extended/qb-core

# First step:
Go into ox_inventory/web/images and put all images from INSTALLATION into the folder.

# Second step:
Go into ox_inventory/data/items.lua and add all of these if you want different colored backpacks:

	['backpackgrey'] = {
		label = 'Grey Backpack',
		weight = 10000,
		stack = false,
		consume = 0,
		client = {
            image = "backpackgrey.png",
			export = 'hn_backpack.openBackpack'
		}
	},
    
    ['backpackred'] = {
		label = 'Red Backpack',
		weight = 10000,
		stack = false,
		consume = 0,
		client = {
			image = "backpackgrey.png",
			export = 'hn_backpack.openBackpack'
		}
	},
    
    ['backpackblue'] = {
		label = 'Blue Backpack',
		weight = 10000,
		stack = false,
		consume = 0,
		client = {
			image = "backpackgrey.png",
			export = 'hn_backpack.openBackpack'
		}
	},
    
    ['backpackgreen'] = {
		label = 'Green Backpack',
		weight = 10000,
		stack = false,
		consume = 0,
		client = {
			image = "backpackgrey.png",
			export = 'hn_backpack.openBackpack'
		}
	},
    
    ['backpackpurple'] = {
		label = 'Purple Backpack',
		weight = 10000,
		stack = false,
		consume = 0,
		client = {
			image = "backpackgrey.png",
			export = 'hn_backpack.openBackpack'
		}
	},

# Third step:
Go into ox_inventory/modules/items/containers.lua and add all of these if you want different colored backpacks:
You can configure how many slots you want, how much weight, whitelisted items, or blacklisted items!

```
setContainerProperties('backpackgrey', {
		slots = 25,
		maxWeight = 200000,
})

setContainerProperties('backpackred', {
		slots = 25,
		maxWeight = 200000,
})

setContainerProperties('backpackblue', {
		slots = 25,
		maxWeight = 200000,
})

setContainerProperties('backpackgreen', {
		slots = 25,
		maxWeight = 200000,
})

setContainerProperties('backpackpurple', {
		slots = 25,
		maxWeight = 200000,
})
```

# Fourth step:
Put all files into resources folder

# Fifth step:
Go into server.cfg and add this line:

```
ensure hn_backpack
```

# Sixth step:
Restart your server and enjoy!

