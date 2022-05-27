#include <man/entity.h>
#include <sys/ai.h>
#include <man/game.h>

//-------------------------------------------------------------------------------
// UPDATE ONE ENTITY
//      Actualiza las físicas de una entidad, basándose en su comportamiento. 
// INPUT: 
//      *e -> puntero a la entidad
//
void sys_ai_behaviour_mothership(Entity_t* e) {
    if(e->x == 20) {
        man_game_create_enemy(e);
    }
    sys_ai_behaviour_left_right(e);
}

void sys_ai_behaviour_left_right(Entity_t* e) {
    const u8 right_bound = 80 - e->w;

    if      (e->x == 0)           e->vx = 1;
    else if (e->x == right_bound) e->vx = -1;
}

void sys_ai_update_one_entity (Entity_t* e) {
    e->ai_vehaviour(e);
}

void sys_ai_update() {
    // for all entities
    man_entity_forall_matching(sys_ai_update_one_entity, e_type_movable | e_type_ai);
}