# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

teacher = Teacher.find(1)

teacher.students.create(name: 'Aarav Sharma', subject_name: 'Mathematics', marks: 85)
teacher.students.create(name: 'Ishita Verma', subject_name: 'Science', marks: 90)
teacher.students.create(name: 'Rahul Mehta', subject_name: 'History', marks: 78)
teacher.students.create(name: 'Sneha Patel', subject_name: 'English', marks: 88)
teacher.students.create(name: 'Karthik Rao', subject_name: 'Physics', marks: 92)
teacher.students.create(name: 'Neha Gupta', subject_name: 'Biology', marks: 89)
teacher.students.create(name: 'Rohan Desai', subject_name: 'Chemistry', marks: 76)
teacher.students.create(name: 'Ananya Iyer', subject_name: 'Geography', marks: 82)
