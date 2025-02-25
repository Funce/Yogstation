//Nearsightedness restricts your vision by several tiles.
/datum/mutation/human/nearsight
	name = "Near Sightness"
	desc = "The holder of this mutation has poor eyesight."
	quality = MINOR_NEGATIVE
	text_gain_indication = span_danger("You can't see very well.")

/datum/mutation/human/nearsight/on_acquiring(mob/living/carbon/human/owner)
	if(..())
		return
	owner.become_nearsighted(GENETIC_MUTATION)

/datum/mutation/human/nearsight/on_losing(mob/living/carbon/human/owner)
	if(..())
		return
	owner.cure_nearsighted(GENETIC_MUTATION)


//Blind makes you blind. Who knew?
/datum/mutation/human/blind
	name = "Blindness"
	desc = "Renders the subject completely blind."
	quality = NEGATIVE
	text_gain_indication = span_danger("You can't seem to see anything.")

/datum/mutation/human/blind/on_acquiring(mob/living/carbon/human/owner)
	if(..())
		return
	owner.become_blind(GENETIC_MUTATION)

/datum/mutation/human/blind/on_losing(mob/living/carbon/human/owner)
	if(..())
		return
	owner.cure_blind(GENETIC_MUTATION)


/datum/mutation/human/thermal
	name = "Thermal Vision"
	desc = "The user of this genome can visually percieve the unique human thermal signature."
	quality = POSITIVE
	difficulty = 18
	text_gain_indication = span_notice("You can see the heat rising off of your skin...")
	time_coeff = 2
	locked = TRUE
	instability = 40
	var/visionflag = TRAIT_THERMAL_VISION

/datum/mutation/human/thermal/on_acquiring(mob/living/carbon/human/owner)
	if(..())
		return

	ADD_TRAIT(owner, visionflag, GENETIC_MUTATION)
	owner.update_sight()

/datum/mutation/human/thermal/on_losing(mob/living/carbon/human/owner)
	if(..())
		return
	REMOVE_TRAIT(owner, visionflag, GENETIC_MUTATION)
	owner.update_sight()

//X-ray Vision lets you see through walls.
/datum/mutation/human/thermal/x_ray
	name = "X Ray Vision"
	desc = "A strange genome that allows the user to see between the spaces of walls." //actual x-ray would mean you'd constantly be blasting rads, wich might be fun for later //hmb
	text_gain_indication = span_notice("The walls suddenly disappear!")
	instability = 35
	locked = TRUE
	visionflag = TRAIT_XRAY_VISION

//Laser Eyes lets you shoot lasers from your eyes!
/datum/mutation/human/laser_eyes
	name = "Laser Eyes"
	desc = "Reflects concentrated light back from the eyes."
	quality = POSITIVE
	locked = TRUE
	difficulty = 16
	text_gain_indication = span_notice("You feel pressure building up behind your eyes.")
	limb_req = BODY_ZONE_HEAD

/datum/mutation/human/laser_eyes/on_ranged_attack(atom/target, mouseparams)
	if(owner.a_intent == INTENT_HARM)
		owner.LaserEyes(target, mouseparams)
