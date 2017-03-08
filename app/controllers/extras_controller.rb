class ExtrasController < ApplicationController

    # ======= ======= states ======= =======

    @@ORDER_STATES = ["pending", "ordered", "processing", "shipping", "delivered", "confirmed", "canceled"]
    @@ORDER_STATE = nil

    def init
        puts "******* init *******"
        @ORDER_STATE = nil
        @order_state = ""
        render template: "extras/init"
    end

    # initial state	event	final state
    # nil         submit	    ordered
    # ordered     process     processing
    # processing  ship        shipping
    # shipping    deliver     delivered
    # delivered   confirm     confirmed
    # <any>       cancel      cancelled

    def update_state
        puts "******* update_state *******"
        puts "** params.inspect: #{params.inspect}"
        puts "** params[:event]: #{params[:event]}"
        # events: submit process ship deliver confirm cancel
        @msg = "result state: "

        if params[:event] == "submit"
            if @@ORDER_STATE == nil
                @state = 1
                update_order(@msg)
            else
                @msg = "previous status: #{@@ORDER_STATE}"
                flash[:notice] = @msg
            end
        elsif params[:event] == "process"
            if @@ORDER_STATE == "ordered"
                @state = 2
                update_order(@msg)
            else
                @msg = "previous status: #{@@ORDER_STATE}"
                flash[:notice] = @msg
            end
        elsif params[:event] == "ship"
            if @@ORDER_STATE == "processing"
                @state = 3
                update_order(@msg)
            else
                @msg = "previous status: #{@@ORDER_STATE}"
                flash[:notice] = @msg
            end
        elsif params[:event] == "deliver"
            if @@ORDER_STATE == "shipping"
                @state = 4
                update_order(@msg)
            else
                @msg = "previous status: #{@@ORDER_STATE}"
                flash[:notice] = @msg
            end
        elsif params[:event] == "confirm"
            if @@ORDER_STATE == "delivered"
                @state = 5
                update_order(@msg)
            else
                @msg = "previous status: #{@@ORDER_STATE}"
                flash[:notice] = @msg
            end
        elsif params[:event] == "cancel"
            @state = 6
            update_order(@msg)
        else
            @state = 0
            update_order(@msg)
        end
        # logs the current state
        # print_state
        puts "** @state: #{@state}"
    end

    def update_order(msg)
        puts "******* update_order *******"
        @@ORDER_STATE = @@ORDER_STATES[@state]
        @order_state = @@ORDER_STATE
        puts "** @@ORDER_STATE: #{@@ORDER_STATE}"
        flash[:notice] = msg
        render template: "extras/init"
    end

    def submit
        @state = 1
        @order_state = @@ORDER_STATES[@state]
        render template: "extras/init"
    end

end
