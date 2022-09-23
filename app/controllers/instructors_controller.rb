class InstructorsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :not_found_response
    def index
        render json: Instructor.all, status: :ok
    end

    def create
        new_instructor = Instructor.create!(instructor_params)
        render json: new_instructor, status: :created
    rescue ActiveRecord::RecordInvalid
        render json: {errors: ["invalid record, cannot add to database"]}, status: :unprocessable_entity
    end

    def show
        instructor = find_instructor()
        render json: instructor, serializer: InstructorSerializer, status: :found
    end

    def update
        instructor = find_instructor()
        instructor.update(instructor_params)
        render json: instructor, status: :accepted
    end

    def destroy
        instructor = find_instructor()
        instructor.destroy
        head :no_content
    end

    private
    
    def find_instructor
        return Instructor.find(params[:id])
    end

    def instructor_params
        params.permit(:name)
    end

    def not_found_response
        render json: {error: "instructor not found"}, status: :not_found
    end

end
