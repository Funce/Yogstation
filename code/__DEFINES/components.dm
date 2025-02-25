#define SEND_SIGNAL(target, sigtype, arguments...) ( !target.comp_lookup || !target.comp_lookup[sigtype] ? NONE : target._SendSignal(sigtype, list(target, ##arguments)) )

#define SEND_GLOBAL_SIGNAL(sigtype, arguments...) ( SEND_SIGNAL(SSdcs, sigtype, ##arguments) )

#define COMPONENT_INCOMPATIBLE 1
#define COMPONENT_NOTRANSFER 2

/// Return value to cancel attaching
#define ELEMENT_INCOMPATIBLE 1

/// /datum/element flags
#define ELEMENT_DETACH		(1 << 0)

// How multiple components of the exact same type are handled in the same datum
/// old component is deleted (default)
#define COMPONENT_DUPE_HIGHLANDER		0
/// duplicates allowed
#define COMPONENT_DUPE_ALLOWED			1
/// new component is deleted
#define COMPONENT_DUPE_UNIQUE			2
/// old component is given the initialization args of the new
#define COMPONENT_DUPE_UNIQUE_PASSARGS	4

// All signals. Format:
// When the signal is called: (signal arguments)
// All signals send the source datum of the signal as the first argument

// global signals
// These are signals which can be listened to by any component on any parent
// start global signals with "!", this used to be necessary but now it's just a formatting choice
/// from base of datum/controller/subsystem/mapping/proc/add_new_zlevel(): (list/args)
#define COMSIG_GLOB_NEW_Z "!new_z"
/// called after a successful var edit somewhere in the world: (list/args)
#define COMSIG_GLOB_VAR_EDIT "!var_edit"
/// mob was created somewhere : (mob)
#define COMSIG_GLOB_MOB_CREATED "!mob_created"
/// mob died somewhere : (mob , gibbed)
#define COMSIG_GLOB_MOB_DEATH "!mob_death"
/// global living say plug - use sparingly: (mob/speaker , message)
#define COMSIG_GLOB_LIVING_SAY_SPECIAL "!say_special"
/// called after an explosion happened : (epicenter, devastation_range, heavy_impact_range, light_impact_range, took, orig_dev_range, orig_heavy_range, orig_light_range)
#define COMSIG_GLOB_EXPLOSION "!explosion"
/// crewmember joined the game (mob/living, rank)
#define COMSIG_GLOB_CREWMEMBER_JOINED "!crewmember_joined"
// signals from globally accessible objects
/// from SSsun when the sun changes position : (azimuth)
#define COMSIG_SUN_MOVED "sun_moved"
/// Random event is trying to roll. (/datum/round_event_control/random_event)
/// Called by (/datum/round_event_control/preRunEvent).
#define COMSIG_GLOB_PRE_RANDOM_EVENT "!pre_random_event"
	/// Do not allow this random event to continue.
	#define CANCEL_PRE_RANDOM_EVENT (1<<0)

//////////////////////////////////////////////////////////////////

// /datum signals
/// when a component is added to a datum: (/datum/component)
#define COMSIG_COMPONENT_ADDED "component_added"
/// before a component is removed from a datum because of RemoveComponent: (/datum/component)
#define COMSIG_COMPONENT_REMOVING "component_removing"
/// before a datum's Destroy() is called: (force), returning a nonzero value will cancel the qdel operation
#define COMSIG_PARENT_PREQDELETED "parent_preqdeleted"
/// just before a datum's Destroy() is called: (force), at this point none of the other components chose to interrupt qdel and Destroy will be called
#define COMSIG_PARENT_QDELETING "parent_qdeleting"
/// generic topic handler (usr, href_list)
#define COMSIG_TOPIC "handle_topic"

// /atom signals
#define COMSIG_PARENT_ATTACKBY "atom_attackby"			        //from base of atom/attackby(): (/obj/item, /mob/living, params)
#define COMPONENT_NO_AFTERATTACK 1								//Return this in response if you don't want afterattack to be called
#define COMSIG_ATOM_HULK_ATTACK "hulk_attack"					//from base of atom/attack_hulk(): (/mob/living/carbon/human)
#define COMSIG_PARENT_EXAMINE "atom_examine"                    //from base of atom/examine(): (/mob)
#define COMSIG_ATOM_GET_EXAMINE_NAME "atom_examine_name"		//from base of atom/get_examine_name(): (/mob, list/overrides)
#define COMSIG_PARENT_EXAMINE_MORE "atom_examine_more"			//from base of atom/examine_more(): (/mob)
	//Positions for overrides list
#define EXAMINE_POSITION_ARTICLE 1
#define EXAMINE_POSITION_BEFORE 2
	//End positions
#define COMPONENT_EXNAME_CHANGED 1
#define COMSIG_ATOM_ENTERED "atom_entered"                      //from base of atom/Entered(): (atom/movable/entering, /atom)
#define COMSIG_ATOM_EXIT "atom_exit"							//from base of atom/Exit(): (/atom/movable/exiting, /atom/newloc)
#define COMPONENT_ATOM_BLOCK_EXIT 1
#define COMSIG_ATOM_EXITED "atom_exited"						//from base of atom/Exited(): (atom/movable/exiting, atom/newloc)
#define COMSIG_ATOM_BUMPED "atom_bumped"						//from base of atom/Bumped(): (/atom/movable)
#define COMSIG_ATOM_EX_ACT "atom_ex_act"						//from base of atom/ex_act(): (severity, target)
#define COMSIG_ATOM_EMP_ACT "atom_emp_act"						//from base of atom/emp_act(): (severity)
#define COMSIG_ATOM_FIRE_ACT "atom_fire_act"					//from base of atom/fire_act(): (exposed_temperature, exposed_volume)
#define COMSIG_ATOM_BULLET_ACT "atom_bullet_act"				//from base of atom/bullet_act(): (/obj/item/projectile, def_zone)
#define COMSIG_ATOM_BLOB_ACT "atom_blob_act"					//from base of atom/blob_act(): (/obj/structure/blob)
#define COMSIG_ATOM_ACID_ACT "atom_acid_act"					//from base of atom/acid_act(): (acidpwr, acid_volume)
#define COMSIG_ATOM_EMAG_ACT "atom_emag_act"					//from base of atom/emag_act(): ()
#define COMSIG_ATOM_RAD_ACT "atom_rad_act"						//from base of atom/rad_act(intensity)
#define COMSIG_ATOM_NARSIE_ACT "atom_narsie_act"				//from base of atom/narsie_act(): ()
#define COMSIG_ATOM_RATVAR_ACT "atom_ratvar_act"				//from base of atom/ratvar_act(): ()
#define COMSIG_ATOM_HONK_ACT "atom_honk_act"					//from base of atom/honk_act(): ()
#define COMSIG_ATOM_RCD_ACT "atom_rcd_act"						//from base of atom/rcd_act(): (/mob, /obj/item/construction/rcd, passed_mode)
#define COMSIG_ATOM_SING_PULL "atom_sing_pull"					//from base of atom/singularity_pull(): (S, current_size)
#define COMSIG_ATOM_SET_LIGHT "atom_set_light"					//from base of atom/set_light(): (l_range, l_power, l_color)
#define COMSIG_ATOM_DIR_CHANGE "atom_dir_change"				//from base of atom/setDir(): (old_dir, new_dir)
#define COMSIG_ATOM_CONTENTS_DEL "atom_contents_del"			//from base of atom/handle_atom_del(): (atom/deleted)
#define COMSIG_ATOM_HAS_GRAVITY "atom_has_gravity"				//from base of atom/has_gravity(): (turf/location, list/forced_gravities)
#define COMSIG_ATOM_RAD_PROBE "atom_rad_probe"					//from proc/get_rad_contents(): ()
#define COMPONENT_BLOCK_RADIATION 1
#define COMSIG_ATOM_RAD_CONTAMINATING "atom_rad_contam"			//from base of datum/radiation_wave/radiate(): (strength)
#define COMPONENT_BLOCK_CONTAMINATION 1
#define COMSIG_ATOM_RAD_WAVE_PASSING "atom_rad_wave_pass"		//from base of datum/radiation_wave/check_obstructions(): (datum/radiation_wave, width)
  #define COMPONENT_RAD_WAVE_HANDLED 1
#define COMSIG_ATOM_CANREACH "atom_can_reach"					//from internal loop in atom/movable/proc/CanReach(): (list/next)
#define COMPONENT_BLOCK_REACH 1
#define COMSIG_ATOM_SCREWDRIVER_ACT "atom_screwdriver_act"		//from base of atom/screwdriver_act(): (mob/living/user, obj/item/I)
#define COMSIG_ATOM_INTERCEPT_TELEPORT "intercept_teleport"		//called when teleporting into a protected turf: (channel, turf/origin)
#define COMPONENT_BLOCK_TELEPORT 1
/////////////////
#define COMSIG_ATOM_ATTACK_GHOST "atom_attack_ghost"			//from base of atom/attack_ghost(): (mob/dead/observer/ghost)
#define COMSIG_ATOM_ATTACK_HAND "atom_attack_hand"				//from base of atom/attack_hand(): (mob/user)
#define COMSIG_ATOM_ATTACK_PAW "atom_attack_paw"				//from base of atom/attack_paw(): (mob/user)
#define COMPONENT_NO_ATTACK_HAND 1							//works on all 3.
/////////////////

#define COMSIG_ENTER_AREA "enter_area" 						//from base of area/Entered(): (/area)
#define COMSIG_EXIT_AREA "exit_area" 							//from base of area/Exited(): (/area)

#define COMSIG_CLICK "atom_click"								//from base of atom/Click(): (location, control, params, mob/user)
#define COMSIG_CLICK_SHIFT "shift_click"						//from base of atom/ShiftClick(): (/mob)
#define COMSIG_CLICK_CTRL "ctrl_click"							//from base of atom/CtrlClickOn(): (/mob)
#define COMSIG_CLICK_ALT "alt_click"							//from base of atom/AltClick(): (/mob)
#define COMSIG_CLICK_CTRL_SHIFT "ctrl_shift_click"				//from base of atom/CtrlShiftClick(/mob)
#define COMSIG_MOUSEDROP_ONTO "mousedrop_onto"					//from base of atom/MouseDrop(): (/atom/over, /mob/user)
#define COMPONENT_NO_MOUSEDROP 1
#define COMSIG_MOUSEDROPPED_ONTO "mousedropped_onto"			//from base of atom/MouseDrop_T: (/atom/from, /mob/user)
///from base of mob/MouseWheelOn(): (/atom, delta_x, delta_y, params)
#define COMSIG_MOUSE_SCROLL_ON "mousescroll_on"

// /area signals
#define COMSIG_AREA_ENTERED "area_entered" 						//from base of area/Entered(): (atom/movable/M)
#define COMSIG_AREA_EXITED "area_exited" 							//from base of area/Exited(): (atom/movable/M)

// /turf signals
#define COMSIG_TURF_CHANGE "turf_change"						//from base of turf/ChangeTurf(): (path, list/new_baseturfs, flags, list/transferring_comps)
#define COMSIG_TURF_HAS_GRAVITY "turf_has_gravity"				//from base of atom/has_gravity(): (atom/asker, list/forced_gravities)
#define COMSIG_TURF_MULTIZ_NEW "turf_multiz_new"				//from base of turf/New(): (turf/source, direction)


// /atom/movable signals
#define COMSIG_MOVABLE_PRE_MOVE "movable_pre_move"					//from base of atom/movable/Moved(): (/atom)
#define COMPONENT_MOVABLE_BLOCK_PRE_MOVE 1
#define COMSIG_MOVABLE_MOVED "movable_moved"					//from base of atom/movable/Moved(): (/atom, dir)
#define COMSIG_MOVABLE_CROSS "movable_cross"					//from base of atom/movable/Cross(): (/atom/movable)
#define COMSIG_MOVABLE_CROSSED "movable_crossed"                //from base of atom/movable/Crossed(): (/atom/movable)
#define COMSIG_MOVABLE_UNCROSS "movable_uncross"				//from base of atom/movable/Uncross(): (/atom/movable)
#define COMPONENT_MOVABLE_BLOCK_UNCROSS 1
#define COMSIG_MOVABLE_UNCROSSED "movable_uncrossed"            //from base of atom/movable/Uncrossed(): (/atom/movable)
#define COMSIG_MOVABLE_BUMP "movable_bump"						//from base of atom/movable/Bump(): (/atom)
#define COMSIG_MOVABLE_IMPACT "movable_impact"					//from base of atom/movable/throw_impact(): (/atom/hit_atom, /datum/thrownthing/throwingdatum)
#define COMSIG_MOVABLE_IMPACT_ZONE "item_impact_zone"			//from base of mob/living/hitby(): (mob/living/target, hit_zone)
#define COMSIG_MOVABLE_BUCKLE "buckle"							//from base of atom/movable/buckle_mob(): (mob, force)
#define COMSIG_MOVABLE_UNBUCKLE "unbuckle"						//from base of atom/movable/unbuckle_mob(): (mob, force)
#define COMSIG_MOVABLE_PRE_DROPTHROW "movable_pre_dropthrow"	//from base of atom/movable/throw_at(): Triggers when throwing, before the item is dropped and before COMSIG_MOVABLE_PRE_THROW 
#define COMSIG_MOVABLE_PRE_THROW "movable_pre_throw"			//from base of atom/movable/throw_at(): (list/args)
#define COMPONENT_CANCEL_THROW 1
#define COMSIG_MOVABLE_POST_THROW "movable_post_throw"			//from base of atom/movable/throw_at(): (datum/thrownthing, spin)
#define COMSIG_MOVABLE_Z_CHANGED "movable_ztransit" 			//from base of atom/movable/onTransitZ(): (old_z, new_z)
#define COMSIG_MOVABLE_SECLUDED_LOCATION "movable_secluded" 	//called when the movable is placed in an unaccessible area, used for stationloving: ()
#define COMSIG_MOVABLE_HEAR "movable_hear"						//from base of atom/movable/Hear(): (proc args list(message, atom/movable/speaker, message_language, raw_message, radio_freq, list/spans, message_mode))
#define HEARING_MESSAGE 1
#define HEARING_SPEAKER 2
//#define HEARING_LANGUAGE 3
#define HEARING_RAW_MESSAGE 4
	/* #define HEARING_RADIO_FREQ 5
#define HEARING_SPANS 6
#define HEARING_MESSAGE_MODE 7 */
#define COMSIG_MOVABLE_DISPOSING "movable_disposing"			//called when the movable is added to a disposal holder object for disposal movement: (obj/structure/disposalholder/holder, obj/machinery/disposal/source)
#define COMSIG_MOVABLE_UPDATE_GLIDE_SIZE "movable_glide_size"	//Called when the movable's glide size is updated: (new_glide_size)

// /datum/song signals

///sent to the instrument when a song starts playing
#define COMSIG_SONG_START 	"song_start"
///sent to the instrument when a song stops playing
#define COMSIG_SONG_END		"song_end"

// /mob signals
///from base of /mob/Login(): ()
#define COMSIG_MOB_LOGIN "mob_login"
///from base of /mob/Logout(): ()
#define COMSIG_MOB_LOGOUT "mob_logout"
#define COMSIG_MOB_DEATH "mob_death"							//from base of mob/death(): (gibbed)
#define COMSIG_MOB_CLICKON "mob_clickon"						//from base of mob/clickon(): (atom/A, params)
#define COMSIG_MOB_CANCEL_CLICKON 1
#define COMSIG_MOB_ALLOWED "mob_allowed"						//from base of obj/allowed(mob/M): (/obj) returns bool, if TRUE the mob has id access to the obj
#define COMSIG_MOB_RECEIVE_MAGIC "mob_receive_magic"			//from base of mob/anti_magic_check(): (mob/user, magic, holy, tinfoil, chargecost, self, protection_sources)
#define COMPONENT_BLOCK_MAGIC 1
#define COMSIG_MOB_HUD_CREATED "mob_hud_created"				//from base of mob/create_mob_hud(): ()
#define COMSIG_MOB_ATTACK_HAND "mob_attack_hand"				//from base of
#define COMSIG_MOB_ATTACK_HAND_TURF "mob_attack_hand_turf"		//from the base of turf/attack_hand
#define COMSIG_MOB_ITEM_ATTACK "mob_item_attack"				//from base of /obj/item/attack(): (mob/M, mob/user)
#define COMSIG_MOB_APPLY_DAMAGE	"mob_apply_damage"				//from base of /mob/living/proc/apply_damage(): (damage, damagetype, def_zone)
#define COMSIG_MOB_ITEM_AFTERATTACK "mob_item_afterattack"		//from base of obj/item/afterattack(): (atom/target, mob/user, proximity_flag, click_parameters)
#define COMSIG_MOB_ATTACK_RANGED "mob_attack_ranged"			//from base of mob/RangedAttack(): (atom/A, params)
#define COMSIG_MOB_THROW "mob_throw"							//from base of /mob/throw_item(): (atom/target)
#define COMSIG_MOB_TABLING "mob_tabling"						//form base of /obj/structure/table_place() and table_push(): (mob/living/user, mob/living/pushed_mob)
#define COMSIG_MOB_EXAMINATE "mob_examinate"					//from base of /mob/verb/examinate(): (atom/target)
#define COMSIG_MOB_EYECONTACT "mob_eyecontact"					///from /mob/living/handle_eye_contact(): (mob/living/other_mob)
#define COMSIG_BLOCK_EYECONTACT (1<<0)							/// return this if you want to block printing this message to this person, if you want to print your own (does not affect the other person's message)
#define COMSIG_MOB_UPDATE_SIGHT "mob_update_sight"				//from base of /mob/update_sight(): ()
#define COMSIG_MOB_SAY "mob_say" // from /mob/living/say(): ()
#define COMPONENT_UPPERCASE_SPEECH 1
	// used to access COMSIG_MOB_SAY argslist
#define SPEECH_MESSAGE 1
	// #define SPEECH_BUBBLE_TYPE 2
#define SPEECH_SPANS 3
	/* #define SPEECH_SANITIZE 4
#define SPEECH_LANGUAGE 5
#define SPEECH_IGNORE_SPAM 6
#define SPEECH_FORCED 7 */

// /mob/living signals
#define COMSIG_LIVING_RESIST "living_resist"					//from base of mob/living/resist() (/mob/living)
#define COMSIG_LIVING_IGNITED "living_ignite"					//from base of mob/living/IgniteMob() (/mob/living)
#define COMSIG_LIVING_EXTINGUISHED "living_extinguished"		//from base of mob/living/ExtinguishMob() (/mob/living)
#define COMSIG_LIVING_ELECTROCUTE_ACT "living_electrocute_act"		//from base of mob/living/electrocute_act(): (shock_damage)
#define COMSIG_LIVING_MINOR_SHOCK "living_minor_shock"			//sent by stuff like stunbatons and tasers: ()
#define COMSIG_PROCESS_BORGCHARGER_OCCUPANT "living_charge"		//sent from borg recharge stations: (amount, repairs)
#define COMSIG_MOB_CLIENT_LOGIN "comsig_mob_client_login"		//sent when a mob/login() finishes: (client)
#define COMSIG_LIVING_SHOCK_PREVENTED "living_shock_prevented"	///sent when items with siemen coeff. of 0 block a shock: (power_source, source, siemens_coeff, dist_check)

//ALL OF THESE DO NOT TAKE INTO ACCOUNT WHETHER AMOUNT IS 0 OR LOWER AND ARE SENT REGARDLESS!
#define COMSIG_LIVING_STATUS_STUN "living_stun"					//from base of mob/living/Stun() (amount, update, ignore)
#define COMSIG_LIVING_STATUS_KNOCKDOWN "living_knockdown"		//from base of mob/living/Knockdown() (amount, update, ignore)
#define COMSIG_LIVING_STATUS_PARALYZE "living_paralyze"			//from base of mob/living/Paralyze() (amount, update, ignore)
#define COMSIG_LIVING_STATUS_IMMOBILIZE "living_immobilize"		//from base of mob/living/Immobilize() (amount, update, ignore)
#define COMSIG_LIVING_STATUS_UNCONSCIOUS "living_unconscious"	//from base of mob/living/Unconscious() (amount, update, ignore)
#define COMSIG_LIVING_STATUS_SLEEP "living_sleeping"			//from base of mob/living/Sleeping() (amount, update, ignore)
#define COMPONENT_NO_STUN 1			//For all of them

// /mob/living/carbon physiology signals
#define COMSIG_CARBON_GAIN_WOUND "carbon_gain_wound"				//from /datum/wound/proc/apply_wound() (/mob/living/carbon/C, /datum/wound/W, /obj/item/bodypart/L)
#define COMSIG_CARBON_LOSE_WOUND "carbon_lose_wound"				//from /datum/wound/proc/remove_wound() (/mob/living/carbon/C, /datum/wound/W, /obj/item/bodypart/L)
///from base of /obj/item/bodypart/proc/attach_limb(): (new_limb, special) allows you to fail limb attachment
#define COMSIG_CARBON_ATTACH_LIMB "carbon_attach_limb"
	#define COMPONENT_NO_ATTACH (1<<0)
#define COMSIG_CARBON_REMOVE_LIMB "carbon_remove_limb"			//from base of /obj/item/bodypart/proc/drop_limb(special, dismembered)
#define COMSIG_CARBON_SOUNDBANG "carbon_soundbang"					//from base of mob/living/carbon/soundbang_act(): (list(intensity))
#define COMSIG_CARBON_STATUS_STAMCRIT "living_stamcrit"				//from base of mob/living/carbon/enter_stamcrit()
#define COMSIG_BODYPART_GAUZED	"bodypart_gauzed" // from /obj/item/bodypart/proc/apply_gauze(/obj/item/stack/gauze)
#define COMSIG_BODYPART_GAUZE_DESTROYED	"bodypart_degauzed" // from [/obj/item/bodypart/proc/seep_gauze] when it runs out of absorption
#define COMSIG_CARBON_SPECIESCHANGE "mob_carbon_specieschange" //from  base of mob/living/carbon/set_species(): (new_race)
// /mob/living/simple_animal/hostile signals
#define COMSIG_HOSTILE_ATTACKINGTARGET "hostile_attackingtarget"
#define COMPONENT_HOSTILE_NO_ATTACK 1

// /obj signals
#define COMSIG_OBJ_DECONSTRUCT "obj_deconstruct"				//from base of obj/deconstruct(): (disassembled)
#define COMSIG_OBJ_SETANCHORED "obj_setanchored"				//called in /obj/structure/setAnchored(): (value)

// /obj/machinery signals
#define COMSIG_MACHINERY_BROKEN "machinery_broken"				//from /obj/machinery/obj_break(damage_flag): (damage_flag)
#define COMSIG_MACHINERY_POWER_LOST "machinery_power_lost"			//from base power_change() when power is lost
#define COMSIG_MACHINERY_POWER_RESTORED "machinery_power_restored"	//from base power_change() when power is restored

// /obj/machinery signals
#define COMSIG_MACHINERY_CREWMON_UPDATE "machinery_crewmon_update"				//from /datum/crewmonitor/proc/update_data(z): ()

// /obj/machinery/power/supermatter_crystal signals
/// from /obj/machinery/power/supermatter_crystal/process_atmos(); when the SM delam reaches the point of sounding alarms
#define COMSIG_SUPERMATTER_DELAM_START_ALARM "sm_delam_start_alarm"
/// from /obj/machinery/power/supermatter_crystal/process_atmos(); when the SM sounds an audible alarm
#define COMSIG_SUPERMATTER_DELAM_ALARM "sm_delam_alarm"

// /obj/item signals
#define COMSIG_ITEM_ATTACK "item_attack"						//from base of obj/item/attack(): (/mob/living/target, /mob/living/user)
#define COMSIG_ITEM_ATTACK_SELF "item_attack_self"				//from base of obj/item/attack_self(): (/mob)
#define COMPONENT_NO_INTERACT 1
#define COMSIG_ITEM_ATTACK_OBJ "item_attack_obj"				//from base of obj/item/attack_obj(): (/obj, /mob)
#define COMPONENT_NO_ATTACK_OBJ 1
#define COMSIG_ITEM_PRE_ATTACK "item_pre_attack"				//from base of obj/item/pre_attack(): (atom/target, mob/user, params)
#define COMPONENT_NO_ATTACK 1
#define COMSIG_ITEM_AFTERATTACK "item_afterattack"				//from base of obj/item/afterattack(): (atom/target, mob/user, params)
#define COMSIG_ITEM_EQUIPPED "item_equip"						//from base of obj/item/equipped(): (/mob/equipper, slot)
#define COMSIG_ITEM_DROPPED "item_drop"							//from base of obj/item/dropped(): (mob/user)
#define COMSIG_ITEM_PREDROPPED "item_predrop"					//from base of mob/dropItemToGround(): (mob/user)
#define COMSIG_ITEM_PICKUP "item_pickup"						//from base of obj/item/pickup(): (/mob/taker)
#define COMSIG_ITEM_ATTACK_ZONE "item_attack_zone"				//from base of mob/living/carbon/attacked_by(): (mob/living/carbon/target, mob/living/user, hit_zone)
#define COMSIG_ITEM_IMBUE_SOUL "item_imbue_soul" 				//return a truthy value to prevent ensouling, checked in /obj/effect/proc_holder/spell/targeted/lichdom/cast(): (mob/user)
#define COMSIG_ITEM_MARK_RETRIEVAL "item_mark_retrieval"			//called before marking an object for retrieval, checked in /obj/effect/proc_holder/spell/targeted/summonitem/cast() : (mob/user)
#define COMPONENT_BLOCK_MARK_RETRIEVAL 1
#define COMSIG_ITEM_HIT_REACT "item_hit_react"					//from base of obj/item/hit_reaction(): (list/args)
#define COMSIG_ITEM_REFUND	"item_refund"						//for tc refunding items: (mob/living/user); returns TRUE if refund is allowed, FALSE if not.

// /obj/item/clothing signals
#define COMSIG_SHOES_STEP_ACTION "shoes_step_action"			//from base of obj/item/clothing/shoes/proc/step_action(): ()
#define COMSIG_NECK_STEP_ACTION "neck_step_action"

// /obj/item/implant signals
#define COMSIG_IMPLANT_ACTIVATED "implant_activated"			//from base of /obj/item/implant/proc/activate(): ()
#define COMSIG_IMPLANT_IMPLANTING "implant_implanting"			//from base of /obj/item/implant/proc/implant(): (list/args)
#define COMPONENT_STOP_IMPLANTING 1
#define COMSIG_IMPLANT_OTHER "implant_other"					//called on already installed implants when a new one is being added in /obj/item/implant/proc/implant(): (list/args, obj/item/implant/new_implant)
	//#define COMPONENT_STOP_IMPLANTING 1 //The name makes sense for both
#define COMPONENT_DELETE_NEW_IMPLANT 2
#define COMPONENT_DELETE_OLD_IMPLANT 4
#define COMSIG_IMPLANT_EXISTING_UPLINK "implant_uplink_exists"	//called on implants being implanted into someone with an uplink implant: (datum/component/uplink)
	//This uses all return values of COMSIG_IMPLANT_OTHER

// /obj/item/pda signals
#define COMSIG_PDA_CHANGE_RINGTONE "pda_change_ringtone"		//called on pda when the user changes the ringtone: (mob/living/user, new_ringtone)
#define COMPONENT_STOP_RINGTONE_CHANGE 1
#define COMSIG_PDA_CHECK_DETONATE "pda_check_detonate"
#define COMPONENT_PDA_NO_DETONATE 1

// /obj/item/modular_computer signals
#define COMSIG_NTOS_CHANGE_RINGTONE "ntos_change_ringtone"
#define COMPONENT_NTOS_STOP_RINGTONE_CHANGE 1

// /obj/item/radio signals
#define COMSIG_RADIO_NEW_FREQUENCY "radio_new_frequency"		//called from base of /obj/item/radio/proc/set_frequency(): (list/args)

// /obj/item/pen signals
#define COMSIG_PEN_ROTATED "pen_rotated"						//called after rotation in /obj/item/pen/attack_self(): (rotation, mob/living/carbon/user)

// /obj/item/gun signals
#define COMSIG_MOB_FIRED_GUN "mob_fired_gun"					//called in /obj/item/gun/process_fire (user, target, params, zone_override)

// /obj/item/projectile signals (sent to the firer)
#define COMSIG_PROJECTILE_ON_HIT "projectile_on_hit"			// from base of /obj/item/projectile/proc/on_hit(): (atom/movable/firer, atom/target, Angle)
#define COMSIG_PROJECTILE_BEFORE_FIRE "projectile_before_fire" 			// from base of /obj/item/projectile/proc/fire(): (obj/item/projectile, atom/original_target)


// /mob/living/carbon/human signals
#define COMSIG_HUMAN_EARLY_UNARMED_ATTACK "human_early_unarmed_attack"			//from mob/living/carbon/human/UnarmedAttack(): (atom/target, proximity, modifiers)
#define COMSIG_HUMAN_MELEE_UNARMED_ATTACK "human_melee_unarmed_attack"			//from mob/living/carbon/human/UnarmedAttack(): (atom/target)
#define COMSIG_HUMAN_MELEE_UNARMED_ATTACKBY "human_melee_unarmed_attackby"		//from mob/living/carbon/human/UnarmedAttack(): (mob/living/carbon/human/attacker)
#define COMSIG_HUMAN_DISARM_HIT	"human_disarm_hit"	//Hit by successful disarm attack (mob/living/carbon/human/attacker,zone_targeted)

// /datum/species signals
#define COMSIG_SPECIES_GAIN "species_gain"						//from datum/species/on_species_gain(): (datum/species/new_species, datum/species/old_species)
#define COMSIG_SPECIES_LOSS "species_loss"						//from datum/species/on_species_loss(): (datum/species/lost_species)

/*******Component Specific Signals*******/
//Janitor
#define COMSIG_TURF_IS_WET "check_turf_wet"							//(): Returns bitflags of wet values.
#define COMSIG_TURF_MAKE_DRY "make_turf_try"						//(max_strength, immediate, duration_decrease = INFINITY): Returns bool.
#define COMSIG_COMPONENT_CLEAN_ACT "clean_act"					//called on an object to clean it of cleanables. Usualy with soap: (num/strength)

//Creamed

///called when you wash your face at a sink: (num/strength)
#define COMSIG_COMPONENT_CLEAN_FACE_ACT "clean_face_act"

//Food
#define COMSIG_FOOD_EATEN "food_eaten"		//from base of obj/item/reagent_containers/food/snacks/attack(): (mob/living/eater, mob/feeder)

//Gibs
#define COMSIG_GIBS_STREAK "gibs_streak"						// from base of /obj/effect/decal/cleanable/blood/gibs/streak(): (list/directions, list/diseases)

//Mood
#define COMSIG_ADD_MOOD_EVENT "add_mood" //Called when you send a mood event from anywhere in the code.
#define COMSIG_CLEAR_MOOD_EVENT "clear_mood" //Called when you clear a mood event from anywhere in the code.

//NTnet
#define COMSIG_COMPONENT_NTNET_RECEIVE "ntnet_receive"			//called on an object by its NTNET connection component on receive. (sending_id(number), sending_netname(text), data(datum/netdata))

//Nanites
#define COMSIG_HAS_NANITES "has_nanites"						//() returns TRUE if nanites are found
#define COMSIG_NANITE_GET_PROGRAMS	"nanite_get_programs"		//(list/nanite_programs) - makes the input list a copy the nanites' program list
#define COMSIG_NANITE_SET_VOLUME "nanite_set_volume"			//(amount) Sets current nanite volume to the given amount
#define COMSIG_NANITE_ADJUST_VOLUME "nanite_adjust"				//(amount) Adjusts nanite volume by the given amount
#define COMSIG_NANITE_SET_MAX_VOLUME "nanite_set_max_volume"	//(amount) Sets maximum nanite volume to the given amount
#define COMSIG_NANITE_SET_CLOUD "nanite_set_cloud"				//(amount(0-100)) Sets cloud ID to the given amount
#define COMSIG_NANITE_SET_SAFETY "nanite_set_safety"			//(amount) Sets safety threshold to the given amount
#define COMSIG_NANITE_SET_REGEN "nanite_set_regen"				//(amount) Sets regeneration rate to the given amount
#define COMSIG_NANITE_SIGNAL "nanite_signal"					//(code(1-9999)) Called when sending a nanite signal to a mob.
#define COMSIG_NANITE_COMM_SIGNAL "nanite_comm_signal"			//(comm_code(1-9999), comm_message) Called when sending a nanite comm signal to a mob.
#define COMSIG_NANITE_SCAN "nanite_scan"						//(mob/user, full_scan) - sends to chat a scan of the nanites to the user, returns TRUE if nanites are detected
#define COMSIG_NANITE_UI_DATA "nanite_ui_data"					//(list/data, scan_level) - adds nanite data to the given data list - made for ui_data procs
#define COMSIG_NANITE_ADD_PROGRAM "nanite_add_program"			//(datum/nanite_program/new_program, datum/nanite_program/source_program) Called when adding a program to a nanite component
#define COMPONENT_PROGRAM_INSTALLED		1					//Installation successful
#define COMPONENT_PROGRAM_NOT_INSTALLED		2				//Installation failed, but there are still nanites
#define COMSIG_NANITE_SYNC "nanite_sync"						//(datum/component/nanites, full_overwrite, copy_activation) Called to sync the target's nanites to a given nanite component

// /datum/component/storage signals
#define COMSIG_CONTAINS_STORAGE "is_storage"							//() - returns bool.
#define COMSIG_TRY_STORAGE_INSERT "storage_try_insert"					//(obj/item/inserting, mob/user, silent, force) - returns bool
#define COMSIG_TRY_STORAGE_SHOW "storage_show_to"						//(mob/show_to, force) - returns bool.
#define COMSIG_TRY_STORAGE_HIDE_FROM "storage_hide_from"				//(mob/hide_from) - returns bool
#define COMSIG_TRY_STORAGE_HIDE_ALL "storage_hide_all"					//returns bool
#define COMSIG_TRY_STORAGE_SET_LOCKSTATE "storage_lock_set_state"		//(newstate)
#define COMSIG_IS_STORAGE_LOCKED "storage_get_lockstate"				//() - returns bool. MUST CHECK IF STORAGE IS THERE FIRST!
#define COMSIG_TRY_STORAGE_TAKE_TYPE "storage_take_type"				//(type, atom/destination, amount = INFINITY, check_adjacent, force, mob/user, list/inserted) - returns bool - type can be a list of types.
#define COMSIG_TRY_STORAGE_FILL_TYPE "storage_fill_type"				//(type, amount = INFINITY, force = FALSE)			//don't fuck this up. Force will ignore max_items, and amount is normally clamped to max_items.
#define COMSIG_TRY_STORAGE_TAKE "storage_take_obj"						//(obj, new_loc, force = FALSE) - returns bool
#define COMSIG_TRY_STORAGE_QUICK_EMPTY "storage_quick_empty"			//(loc) - returns bool - if loc is null it will dump at parent location.
#define COMSIG_TRY_STORAGE_RETURN_INVENTORY "storage_return_inventory"	//(list/list_to_inject_results_into, recursively_search_inside_storages = TRUE)
#define COMSIG_TRY_STORAGE_CAN_INSERT "storage_can_equip"				//(obj/item/insertion_candidate, mob/user, silent) - returns bool

// /datum/action signals
#define COMSIG_ACTION_TRIGGER "action_trigger"						//from base of datum/action/proc/Trigger(): (datum/action)
#define COMPONENT_ACTION_BLOCK_TRIGGER 1

/*******Non-Signal Component Related Defines*******/

//Redirection component init flags
#define REDIRECT_TRANSFER_WITH_TURF 1

//Arch
#define ARCH_PROB "probability"					//Probability for each item
#define ARCH_MAXDROP "max_drop_amount"				//each item's max drop amount

//Ouch my toes!
#define CALTROP_BYPASS_SHOES 1
#define CALTROP_IGNORE_WALKERS 2

//Xenobio hotkeys
#define COMSIG_XENO_SLIME_CLICK_CTRL "xeno_slime_click_ctrl"				//from slime CtrlClickOn(): (/mob)
#define COMSIG_XENO_SLIME_CLICK_ALT "xeno_slime_click_alt"					//from slime AltClickOn(): (/mob)
#define COMSIG_XENO_SLIME_CLICK_SHIFT "xeno_slime_click_shift"				//from slime ShiftClickOn(): (/mob)
#define COMSIG_XENO_TURF_CLICK_SHIFT "xeno_turf_click_shift"				//from turf ShiftClickOn(): (/mob)
#define COMSIG_XENO_TURF_CLICK_CTRL "xeno_turf_click_alt"					//from turf AltClickOn(): (/mob)
#define COMSIG_XENO_MONKEY_CLICK_CTRL "xeno_monkey_click_ctrl"				//from monkey CtrlClickOn(): (/mob)

/// job subsystem has spawned and equipped a new mob
#define COMSIG_GLOB_JOB_AFTER_SPAWN "!job_after_spawn"

///Subsystem signals
///From base of datum/controller/subsystem/Initialize: (start_timeofday)
#define COMSIG_SUBSYSTEM_POST_INITIALIZE "subsystem_post_initialize"

/// called by datum/cinematic/play() : (datum/cinematic/new_cinematic)
#define COMSIG_GLOB_PLAY_CINEMATIC "!play_cinematic"
#define COMPONENT_GLOB_BLOCK_CINEMATIC (1<<0)

///Called when an object is grilled ontop of a griddle
#define COMSIG_ITEM_GRILLED "item_griddled"
#define COMPONENT_HANDLED_GRILLING (1<<0)
///Called when an object is turned into another item through grilling ontop of a griddle
#define COMSIG_GRILL_COMPLETED "item_grill_completed"
//Called when an object is in an oven
#define COMSIG_ITEM_BAKED "item_baked"
#define COMPONENT_HANDLED_BAKING (1<<0)
#define COMPONENT_BAKING_GOOD_RESULT (1<<1)
#define COMPONENT_BAKING_BAD_RESULT (1<<2)
///Called when an object is turned into another item through baking in an oven
#define COMSIG_BAKE_COMPLETED "item_bake_completed"
