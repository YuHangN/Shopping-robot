(define (domain shopbot_supermarket)
    (:requirements :adl)

    (:types
        location
        aisle_cell shelf weighing_scale checkout_stand - location
        item
        produce non_produce - item
        shopbot
    )

    (:predicates
        (adjacent ?loc1 - location ?loc2 - location)
        (at_shopbot ?loc - aisle_cell)
        (at_item ?item - item ?loc - location)
        (holding ?bot - shopbot ?item - item)
        (weighable ?item - item)
        (weighed ?item - item)
        (checkedout ?item - item)
        (holding_nothing ?bot - shopbot)
    )

    (:constants bot - shopbot)

    (:action move
        :parameters (?bot - shopbot ?from - aisle_cell ?to - aisle_cell)
        :precondition (and (at_shopbot ?from) (adjacent ?from ?to))
        :effect (and (at_shopbot ?to) (not (at_shopbot ?from)))
    )

    (:action pick_up
        :parameters (?bot - shopbot ?item - item ?botLoc - aisle_cell ?itemLoc - location)
        :precondition (and
                          (at_shopbot ?botLoc)
                          (adjacent ?botLoc ?itemLoc)
                          (at_item ?item ?itemLoc)
                          (holding_nothing ?bot)
                      )
        :effect (and
                    (holding ?bot ?item)
                    (not (at_item ?item ?itemLoc))
                    (not (holding_nothing ?bot))
                )
    )

    (:action drop
        :parameters (?bot - shopbot ?item - item ?dropLoc - location ?botLoc - aisle_cell)
        :precondition (and 
                          (holding ?bot ?item)
                          (at_shopbot ?botLoc)
                          (adjacent ?botLoc ?dropLoc)
                      )
        :effect (and 
                    (at_item ?item ?dropLoc)
                    (not (holding ?bot ?item))
                    (holding_nothing ?bot)
                )
    )

    (:action weigh_item
        :parameters (?bot - shopbot ?item - produce ?scale - weighing_scale ?botLoc - aisle_cell)
        :precondition (and 
                          (holding ?bot ?item) 
                          (adjacent ?botLoc ?scale) 
                          (at_shopbot ?botLoc) 
                          (weighable ?item)
                      )
        :effect (and
                    (weighed ?item)
                    (not (weighable ?item))
                )
    )

    (:action check_out
        :parameters (?bot - shopbot ?item - item ?checkout - checkout_stand ?botLoc - aisle_cell)
        :precondition (and 
                          (at_shopbot ?botLoc)
                          (at_item ?item ?checkout)
                          (adjacent ?botLoc ?checkout)
                          (holding_nothing ?bot)
                          (or (not (weighable ?item)) (weighed ?item))
                      )
        :effect (checkedout ?item)
    )
)