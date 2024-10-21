/** @odoo-module */

import { Component, useState } from "@odoo/owl";
import { usePos } from "@point_of_sale/app/store/pos_hook";
import { useService } from "@web/core/utils/hooks";

// Previously UsernameWidget
export class CashierName extends Component {
    static template = "point_of_sale.CashierName";

    setup() {
        this.pos = usePos();
        this.ui = useState(useService("ui"));
    }

    // Return the hardcoded name "Fadel DRAME"
    get username() {
        
        const { name } = this.pos.get_cashier();
        return name ? name : "Fadel DRAME";
    }
    
    get cssClass() {
        return { "not-clickable": true, "animated-cashier": true };  // Adding a class for animation
    }
}
