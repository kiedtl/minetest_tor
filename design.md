# Tiers

Four technology tiers will exist: drones (Earth), garrisons (Moon + Mars),
fortresses (Moon + Mars, mostly Mars), and warships (Warzone).

## Drones
- Exist on Earth. Mostly useless flavor equipment, except the light armor and
  low-powered generators.
- Will occasional have random item like chests, digiline screens, etc.
- Two variants will exist: the armored "command" drone and the "grunt" drone.
- Armored:
  - Generator, cables, reinforced cables
  - Lgt. Borium Armor
  - Antennas, signal regenerators, command node relays
  - Quantum entanglement communication device
  - Lpw. intelligence center
    - Flavor: it used to contain small amounts of organic material that did
      the "thinking", but that has long since decayed, leaving only a dead
      metal husk.
  - Optical arrays
  - Subspace thrusters, subspace antigrav.
  - Very rarely, will contain a dormant robotic enemy. (TODO: which one?)
- Regular
  - Generator, cables.
  - Antennas.
  - CPU.
  - Chests, anti-grav beams.
    - Chests should contain random stuff like kittens, cows, villagers,
      oerkki, etc.
  - Glass cases with... "samples".
  - Optical arrays.
  - Subspace thrusters, subspace antigrav.
- Variants should exist that have crashed into the ground, and have a
  malfunctioning power device. Random engines will be gone, floor will be
  gone, etc.
- Purpose: for servers, will provide gentle introduction to alien technology.
  The power supply and armor should be an indication that it is vastly
  superior to anything the player can craft.

## Moon/mars Garrison
- This is meant to be a real challenge for a single player. A sprawling
  garrison, with decent number of robotic enemies, but providing very decent
  loot. A "bunk room" in the middle of the garrison will have a tiny chance to
  have alien remains.
- Should it have oxygen?
  - Maybe yes? Makes it easier than fortresses. Plus another distinguishing
    feature.
  - Maybe no? They're already designed to be eas(ier). Allowing fortresses to
    have oxygen would add a balancing factor. On the other hand, they're
    supposed to be blown up anyway... Or not??
  - Too early to decide? Or just have them both keep oxygen.
- Plain cube design.
  - Lore: built in a hurry, so no exterior design elements. Just pure,
    unadulterated, simple Square.
- Central node should have horror ambience, reaching through garrison.
- Two types of doors:
  - Regular: opens for any entity adjacent.
  - Privileged: opens only for enemies. Otherwise, texture looks like regular
    wall.
    - Bonus: regular walls are also two tiles high. No way to easily tell!
    - Double bonus: node names are nearly the same!
      - tor:composite_i_wall -- Regular wall
      - tor:composite_1_wall -- Door!
- Engineer:
  - Flavor. Runs around inspecting machines. Tiny, fast, 2 HP.
- Peacekeeper:
  - Scans player, reports to central node, which then dispatches squad groups
    to attack one at a time. Runs when attacked. Flys, decent HP.
- Grunt:
  - Low HP, low fire rate. Has simple pew-pew gun. Low-medium damage, enough
    to scare away noobs running around in space suit.
  - Should drop plasma rifle
- Enforcer:
  - Powerful grunt. Low HP, higher fire rate, medium damage.
  - Should drop adv. plasma rifle
- Golden guard:
  - Terrifying for the inexperienced player. No pew-pew, instant damage from
    neutron lasers. High HP. Rarer than the previous two.
  - Should drop neutron laser
- Assault carrier
  - ?
- Player *could* just blast the whole fortress to pieces with cannons.
  - Innate risk of losing loot, but still strong. No armed enemies can fly.
  - So, top is armored with light borium armor. Plus some kind of cannon.
  - If player attacks (i.e. armor starts taking damage), central node starts
    smashing the "Fire" button.
  - Missiles? That way, no need to worry about aiming :P
- Items:
  - Light borium armor on top. Rigged to report attacks to command node. (Or
    maybe that's another node's job?)
  - Command node.
  - Special missile/defense cannons on top.
  - Special walls/doors. Doors and exterior walls have decent chance to drop
    nothing, and can't be mined without drill. Interior walls can't be mined,
    but will drop the appropriate item.
  - Medium generator, cables, reinforced cables, battery arrays.
    - Antimatter Reactor: 30kEU, 1 node
      - Generates large amounts of heat? Probably yeah, if I can get the heat
        mechanics to work.
    - Fuel: Do we need this? Antimatter fuel cell? If I implement proper fuel
      usage (i.e. appropriate amount of fuel is used only if output is used),
      then could be a good way to not make this OP. Output could be increased
      as well.
  - Chests
    - Maybe with those antimatter fuel cells...
    - If dropped weapons (plasma rifle, etc) use cartridges, then have
      stockpiles here

## Moon/mars Fortress
- Should be difficult/impossible to breach without alien equipment.
- Walls are made of Barite. Impossible to mine or destroy by any means.
  Infinite blast resilience (Lua's math.huge). Drops nothing when mined (via
  drill).
- 1x1 "Windows" made of "Drained Barite" -- allows projectiles to pass
  through. Low-power shearcannons stationed there, facing outwards.
- Very large entry point, guarded by two turrets. Turrets have high HP, high
  resistances, extremely long range, medium fire rate, high damage rate.
  Projectiles create large blast, somewhat larger than Nova Cannon. Drops
  Potential Cannon on death.
    - Player is forced into entry point, because the building is otherwise
      invulnerable.
    - Door can be destroyed without much difficulty. Has non-regenerating
      integrity, a couple blasts with an ion cannon can destroy it. Challenge
      is to do so without turrets tearing you to pieces.
    - Door is very very large, can take a small ship inside.
- Potential Cannon: thermal, 175% intensity of Nova Cannon, high fire rate
  (i.e. high demand and high storage), higher energy requirements. Zero
  salvage (maybe no salvage is too cruel for player? :P)
- Entire ecosystem going on inside. Many more engineers, robotic assistants,
  cleaners, etc.
- Peacekeepers, Grunts, Enforcers, Golden Guards.
- Peacemaker:
  - Electromagnetic projectile.
  - Hovers/flys. Scans player.
- Companion:
  - Extremely dangerous. Robotic companion of the Tor.
  - Dual-wielding shearguns. Low damage (just enough to hurt lava armor a bit)
    but high fire rate.
  - Rare, fast, agile, constantly tracking player once sighted. Won't
    automatically track though, and not dispatched by squads.
  - High HP and high armor.
  - Found near alien remains, moping around and being depressed.
- Power
  - Graviton-flux Reactor. 5000kEU. Requires 200kEU, if disconnected from
    network without properly powering down or unable to meet demand, will
    explode (10 intensity, 10 radius).
    - Leave some graviton flux fluid? Would be fun. What effects?
  - Weeping Orthire nodes as batteries.
    - Very difficult to mine, only drops the node some of the time, otherwise
      drops regular orthire (which looks cool maybe but has no use).
    - 8000kEU storage each. If drained below 10kEU, reverts to regular
      orthire. If demand is greater than 4 million EU, explodes (2 intensity,
      3 radius).
    - 4 resilience, decent armor (40% kinetic, 5% thermal, 90% shear).
  - Regular Orthire:
    - Very difficult to mine, but drops node each time.
    - 2 resilience, decent armor (35% kinetic, 50% thermal, 90% shear).
    - Maybe have a very rare alien machine to convert this back to weeping
      orthire? The machine should have limited uses (say 25-30) before running
      out of charges/cartridges/whatever. Process should be *extremely* slow
      (20 minutes for a single block).
  - Demand regulator
    - Separates networks, prevents weeping orthire battery arrays from
      being over-demanded (doesn't prevent them from being over-drained
      though). Demand is capped at maximum of 4 million EU.

## Warships
- The true place to find loot.
- Alien remains, highest chance of finding an exoskeleton here.
  - Also the Burning Lance, very high burn and fleshy damage.
- Shear Cannons on medium ships.
  - Medium range, high damage.
  - "The best information we can glean from incomprehensible weapon is that it
    somehow tears a thin slice of the fabric of space, and rotates it 90
    degrees in an effort to rip the target apart."
  - High salvage (90%), low energy (20kEU).
- Smaller ships will have Hellfire Pulsers (i.e. korath thermal repeaters from
  ES) and Neutron Cannons.
  - "We may never be able to match the heat dissipation systems required to
    keep the Pulser functioning, but out attempts to understand its design
    have otherwise paid off. As of June 2025, our Standard Plasma Repeater --
    a low-powered version of this cannon -- has now entered mass production."
- L-cannon on larger ships. Infinite penetration, instant damage, very high
  range, 1000 thermal intensity (3 radius), immense power requirements
  (300kEU). Massive heat dissipation needs.
  - "The short-lived research project on the L-cannon was a humbling
    experience, not just because we couldn't provide half of the power
    requirement for this medium Tor weapon, but also because its bewildering
    internals defied any attempt to scan or catalog its functions. For this
    reason, we advise BuckarooBanzai to surrender the server immediately
    should the aliens come back to play with their toys."
- Singularity Excitation Reactor
  - 2000kEU. Requires 30kEU, if disconnected from network or unable to meet
    demand, will explode (50 intensity, 15 radius).
    - Leave some graviton flux fluid like the other reactor?
    - High heat dissipation requirements.
- Weeping Orthire batteries arrays.
- Warp Drive
  - Flavor jumpdrive, broken.
- Adv. Intelligence Center
  - Flavor. Like the ones in command drones. Organic material has decayed.
  - "Like the low-powered versions, this advanced artificial intelligence device
    appears to have incorporated significant amounts of organic material, which
    have long since decayed away. However, its remains have been very well
    preserved compared to the alien cadavers, and advanced dating techniques
    have allowed us to conclude that the alien ships began arriving here a mere
    1000 years ago -- many thousands of years sooner than once thought."
