class AssignmentsController < ApplicationController
    def index
        set_territory
        assignments = @territory.assignments
        render json: assignments
    end

    def create
        set_territory
        assignment = @territory.assignments.build(assignment_params)
        if assignment.save
            render json: assignment
        else
            render json: {error: "unable to save"}, status: :bad_request
        end
    end

    def update
        set_assignment
        if @assignment.update(assignment_params)
            render json: @assignment, status: :ok
        else 
            render json: {error: "unable to save"}, status: :bad_request
        end
    end

    def destroy
        set_assignment
        @assignment.destroy
        render json: {message: "ok"}, status: :ok
    end

    private
        def assignment_params
            params.require(:assignment).permit(:checked_out, :checked_in, :publisher)
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
