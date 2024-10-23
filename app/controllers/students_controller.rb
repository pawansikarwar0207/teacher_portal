class StudentsController < ApplicationController
  before_action :set_student, only: %i[show edit update destroy]
  before_action :authenticate_teacher!

  def index
    @students = current_teacher.students.all.order(updated_at: :desc)
  end

  def show
  end

  def new
    @student = Student.new
	end
  
  def create
	  # Find existing student by name and subject_name
	  @existing_student = Student.find_by(name: student_params[:name], subject_name: student_params[:subject_name])

	  if @existing_student
	    # If found, update the marks with new marks to the existing ones
	    @existing_student.marks = student_params[:marks].to_i
	    if @existing_student.save
	      flash[:notice] = 'Marks were successfully updated for the existing student.'
	      respond_to do |format|
	        format.turbo_stream
	        format.html { redirect_to students_path }
	      end
	    else
	      flash[:alert] = 'Failed to update marks for the existing student.'
	      render :new, status: :unprocessable_entity
	    end
	  else
	    # If not found, create a new student
	    @student = Student.new(student_params)
	    if @student.save
	      flash[:notice] = 'Student was successfully created.'
	      respond_to do |format|
	        format.turbo_stream
	        format.html { redirect_to students_path }
	      end
	    else
	      render :new, status: :unprocessable_entity
	    end
	  end
	end


  def edit
    respond_to do |format|
      format.turbo_stream
      format.html { render :edit }
    end
  end

  def update
	  if @student.update(student_params)
	  	flash[:notice] = 'Student was successfully updated.'
	    respond_to do |format|
	      format.json { head :no_content }
	      format.turbo_stream 
	    end
	  else
	    render json: { error: "Update failed" }, status: :unprocessable_entity
	  end
	end


  def destroy
    @student.destroy
    redirect_to root_path, notice: "Student was successfully deleted."
  end

  private

  def set_student
    @student = Student.find(params[:id])
  end

  def student_params
    params.require(:student).permit(:name, :subject_name, :marks, :teacher_id)
  end
end
