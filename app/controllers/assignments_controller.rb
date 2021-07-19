class AssignmentsController < ApplicationController
    def index
        set_territory
        assignments = @territory.assignments
        render json: assignments
    end

    def create
        assignment = Assignment.new(assignment_params)
        if assignment.save
            render json: assignment
        else
            render json: {error: "unable to save"}, status: :bad_request
        end
    end

    def update
        set_assignment
        if @assignment.update(dnc_params)
            render json: @assignment, status: :ok
        else 
            render json: {error: "unable to save"}, status: :bad_request
    end

    def destroy
        set_assignment
        @assignment.destroy
        render json: {message: "ok"}, status: :ok
    end

    private
        def assignment_params
            params.require(:assignment).permit(:check_out, :check_in, :publisher)
        end

        def set_congregation
            @congregation = Congregation.find(params[:congregation_id])
        end

        def set_territory
            @territory = Territory.find(params[:territory_id])
        end

        def set_assignment
            @assignment = Assignment.find(params[:id])
        end
end
