# Additional Loot

In addition to the loot described below, more loot can appear in chests as a
reward for the player.

- UHV furnaces, grinders, compressors.
  - 2x speed (compared to HV equipment), but 3x energy usage.
- UHV -> HV supply converter.

# Tiers

Four technology tiers will exist: drones (Earth), garrisons (Moon + Mars, mostly
Mars), fortresses (Moon + Mars, mostly Moon), and warships (Warzone).

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
  - Very rarely, will contain a dormant robotic enemy.
    - G-38 Escort: grunts repurposed as drone guards.
      - Pretty weak, low HP, almost no armor.
      - It can hover though.
      - Deployed by machine?
      - "Live human active within protected area. Terminating.
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
      - Explodes when destroyed (by blast).
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
  - Mob version: high knockback.
- Entire ecosystem going on inside. Many more engineers, robotic assistants,
  cleaners, etc.
- Peacekeepers, Grunts, Enforcers, Golden Guards.
- Peacemaker:
  - Broadcast messages (see exoskeleton section):
    - "EXTERMINATE EXTERMINATE EXTERMINAAAATE"
    - lol
    - On death: "MEEERCYYYYY"
  - Electromagnetic projectile.
  - Hovers/flys. Scans player.
- Companion:
  - Extremely dangerous. Intelligent robot companion of the Tor.
  - Broadcast messages (see exoskeleton section):
    - On spotting:
        - "Your equipment belonged to a Commander. What did you do to him?"
        - "I do not recognize your ID. Surrender and take me to your commander at once."
        - "I have been waiting for an eternity. I do not know who you are."
        - "You do not bear the identification of a true Tor Warrior."
        - "My master was recalled and told to leave us behind. You will
           surrender and bring me to him."
        - "Every Warrior I ever knew is lying here. You will not disturb me."
    - On death:
      - "I know my master will return for me."
      - "My master will surely return."
      - "I believe my master will repair me."
      - "My master will avenge my destruction."
    - Player needs to feel like a monster after killing it.
      - On death, maybe the player "splits it open" :P and some wires and
        control systems are dropped.
        - Enh. Intelligence Cell
        - Adv. Memory Center (2x)
        - Data Cables
  - Dual-wielding shearguns. Low damage (just enough to hurt exoskeleton a tiny bit)
    but high fire rate.
    - Of course, since it's shearing damage, with no exo (i.e. no shearing
      protection) it'll have horrifying DPS.
  - Rare, fast, agile, constantly tracking player once sighted. Won't
    automatically track though, and not dispatched by squads.
  - High HP and high armor.
  - Found moping around alien remains, feeling sad and depressed.
- Power
  - Graviton-flux Reactor. 5000kEU. Requires 200kEU, if disconnected from
    network without properly powering down or unable to meet demand, will
    explode (10 intensity, 10 radius).
    - Idea: Produce power in bursts, and produce nothing in between. Will
      complicate formspec design.
      - Adds a strong downside, to pair with its otherwise high qualities. Now
        the 200kEU requirement is a real challenge. For the fortress it'll be
        fine, since there are WO battery arrays everywhere, but for the player
        it'll be a big deal.
    - Leave some graviton flux fluid? Would be fun. What effects?
      - Idea: items dropped in are destroyed, but have very very small chance to
        create an orb of antimatter. This can be processed (very very slowly,
        30+ minutes for a single orb) by a very rare machine into antimatter
        fuel canisters for the Antimatter Reactor.
        - Different version of same idea: very small chance to spawn a graviton
          flare, a non-hostile mob that just hovers around and slowly rises into
          the sky (and hurting any adjacent creature), but which drops the orb
          on a very very rare chance.
          - Idea for farm: dies when in contact with normality field.
    - Explodes when destroyed (by blast).
  - Weeping Orthire nodes as batteries.
    - Very difficult to mine, only drops the node some of the time, otherwise
      drops regular orthire (which looks cool maybe but has no use).
    - 8000kEU storage each. If drained below 10kEU, reverts to regular
      orthire. If demand is greater than 4 million EU, explodes (2 intensity,
      3 radius).
    - Low charge rate, high discharge rate.
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
- Will also have "prison" and "experiment areas". With animal and NPC remains.
  - Prisons are on pedestals in lighted room, with reinforced glass. Animal
    prisons will have a single square with dead grass on it.

## Warships
- The true place to find loot.
- Alien remains, highest chance of finding an exoskeleton here.
  - Exoskeleton: jump bonus, speed bonus (somewhat less than lava boots), water
    breathing, negates realistic suffocation in vacuum, takes up all slots
    (including shield and head), no armor, very fragile. Radiation protection.
    Player can now get over heights of <=1.0. Running speed is much higher.
    - Combat Exoskeleton: as above, but very rare, has full vacuum breathing,
      and very high armor. Only item in game to have decent quantum shearing
      protection (50%?)
    - Unsure if possible: mitigate fall damage somewhat? i.e. change threshold
      from 3 nodes to 4 or something.
    - HUD: can get status on armor.
      - After putting on, logging in, or waking up:
        - "Exoskeleton activated."
        - "Attempted to connect to local relay unit..."
        - "Failure: local quantum entanglement device is not responding."
        - "Attempting to contact ship..."
        - "Timed out."
      - "Exoskeleton integrity is at optimal levels."
      - "Exoskeleton integrity is at suboptimal levels."
      - "Exoskeleton integrity is compromised. Retreat advised."
    - Exoskeleton systems shut down as integrity goes down.
      - 40%: vacuum breathing stops. realistic suffocation is negated.
        - "Pressurization ability disabled. Maintenance required."
      - 30%: water breathing stops.
        - "Oxygen mask compromise. Maintenance required."
      - 25%: jump and speed bonus halved.
        - "Systems at suboptimal level."
      - 20%: thermal resistance halved.
        - "Thermal protection systems at suboptimal level."
      - 10%: jump and speed bonus stops.
        - "Complete destabilization imminent, emergency maneuvers strongly advised."
      - Note: kinetic resistance never goes away. This is intentional, it's an
        inherent part of the exoskeleton design, i.e. a passive feature.
    - Can now get "feedback" from garrison and fortress control nodes, that show
      up on HUD. i.e. a live log on the control node's actions.
      - "BROADCAST: Peacemaker: intruder position confirmed."
      - "BROADCAST: Peacemaker: intruder suspected."
      - "BROADCAST: Peacemaker: attacked, fleeing."
      - "BROADCAST: Dispatching assault squad."
      - "BROADCAST: Command area compromised, requesting reinforcements."
      - "BROADCAST: Failed to contact local relay: Timed out."
      - "BROADCAST: Attempting to contact command warship."
      - "BROADCAST: No response."
    - Needs more downsides.
      - Maybe: ugly purple/blue/green tint.
      - Maybe: sets off alarm in garrisons, fortresses, ships instantly once
        they enter. "Unregistered Tor Exoskeleton within local area, rogue
        warrior suspected. Termination squads dispatched."
        - Every squad activates and heads for player.
        - Garrison: entrance doors stop functioning. Fortress: door is sealed
          with barite.
      - Maybe: all earth mobs run away from player (or attack in case of large
        animals?). Includes NPC mobs. Requires fiddling with mobs_redo mob
        registration info. Unsure if possible.
      - Maybe: Phasic honor devices blow up when player gets too close? (with
        HUD warning about unregistered exoskeleton and all.)
      - Maybe: Hell Sentinel monsters switch to some kind of overpowered spell.
        Earth mining is extra spicy :P Downside: why would player care, at this
        point they are a demigod.
      - Maybe: Player is now taller (say 2.2 nodes), will bang their head
        everywhere. Seems like best option, since exoskeleton is changing player
        model anyway.
    - Note: HUD messages, especially broadcast messages that are coming from
      control nodes in fortresses/garrisons, should convey sense of Tor robots
      and systems screaming into the void -- doing their best to function
      thousands of years after the disappearance or death of the Tor.
  - Tor Longsword: very high fleshy damage, very high attack speed. Damage
    reflection if possible. High knockback.
  - Burning Lance: very high reach, very high burn damage, high fleshy damage.
- Shear Cannons on medium ships. High knockback.
  - Medium range, high damage.
  - "The best information we can glean from incomprehensible weapon is that it
    somehow tears a thin slice of the fabric of space, and continually rotates
    it in an effort to rip the target apart."
  - High salvage (90%), low energy (20kEU).
- Smaller ships will have Hellfire Pulsers (i.e. korath thermal repeaters from
  ES) and Neutron Cannons.
  - "We may never be able to match the heat dissipation systems required to
    keep the Pulser functioning, but out attempts to understand its design
    have otherwise paid off. As of June 2025, our Plasma Streamer --
    a low-powered version of this cannon -- has entered mass production."
- L-cannon on larger ships. Infinite penetration, instant damage, very high
  range, 500 thermal intensity (3 radius), immense power requirements
  (300kEU). Massive heat dissipation needs.
  - Creates "plasma" nodes in destroyed areas, instead of air. 
    - Spreads, maybe? to a maximum of three nodes.
    - Lingers for maybe a minute, then decays into air.
    - Burn damage and suffocation.
  - "The short-lived research project on the L-cannon was a humbling experience,
    not because we couldn't provide half of the power requirement for this
    medium Tor weapon, but rather due to its bewildering internals defying any
    attempt to scan or catalog its functions. Moreover, every eye-witness
    account we have of this cannon in action points to it being unimaginably
    powerful, far beyond the reach of humanity's current capabilities. For
    this reason, we advise BuckarooBanzai to surrender the server immediately
    should the aliens come back to play with their toys."
- Singularity Excitation Reactor
  - 2000kEU. Requires 30kEU, if disconnected from network or unable to meet
    demand, will explode (50 intensity, 15 radius).
    - Leave some graviton flux fluid like the other reactor?
    - High heat dissipation requirements.
  - Explodes when destroyed (by blast).
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
    1000 years ago -- many thousands of years more recent than once thought."
- Phasic honor device
  - Self-destructor, nestled in with vital cable systems (but away from power
    system, which should explode anyway).
  - Absolutely massive low-intensity explosion (2 intensity, 18 radius).
  - Player better be careful if they have penetrating weapons or if they're just
    planning to blast the ship into submission.
- Normality field
  - Destroys shear{cannon, gun} projectiles, 100% of the time.
  - Energy hungry and low radius, disabled by default on the ships. Intended
    only for use by players.
  - Destroys graviton flare (see graviton-flux fluid ideas above).
