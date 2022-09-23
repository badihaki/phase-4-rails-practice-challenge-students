class StudentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :not_found_response

    def index
        render json: Student.all, status: :ok
    end

    def create
        new_student = Student.create!(student_params)
        render json: new_student, status: :created
    rescue ActiveRecord::RecordInvalid
        render json: {errors: ["invalid record, cannot add to database"]}, status: :unprocessable_entity
    end

    def show
        student = find_student()
        render json: student, serializer: StudentSerializer, status: :found
    end

    def update
        student = find_student()
        student.update(student_params)
        render json: student, status: :accepted
    end

    def destroy
        student = find_student()
        student.destroy
        head :no_content
    end

    private
    
    def find_student
        return Student.find(params[:id])
    end

    def student_params
        params.permit(:name, :major, :age)
    end

    def not_found_response
        render json: {error: "instructor not found"}, status: :not_found
    end

end
