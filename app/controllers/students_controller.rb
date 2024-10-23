class StudentsController < ApplicationController
  before_action :set_student, only: %i[show edit update destroy]

  def index
    @students = Student.all
  end

  def show
  end

  def new
    @student = Student.new
	  respond_to do |format|
	    format.turbo_stream # Respond to Turbo stream requests
	    format.html         # Fallback for standard HTML requests
	  end
	end


  def create
    @student = Student.new(student_params)
    if @student.save
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.append('students', partial: 'students/student', locals: { student: @student }) }
        format.html { redirect_to students_path, notice: 'Student was successfully created.' }
      end
    else
      render :new, status: :unprocessable_entity
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
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@student, partial: 'students/student', locals: { student: @student }) }
        format.html { redirect_to students_path, notice: 'Student was successfully updated.' }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @student.destroy
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@student) }
      format.html { redirect_to students_path, notice: 'Student was successfully destroyed.' }
    end
  end

  private

  def set_student
    @student = Student.find(params[:id])
  end

  def student_params
    params.require(:student).permit(:name, :subject_name, :marks, :teacher_id)
  end
end
