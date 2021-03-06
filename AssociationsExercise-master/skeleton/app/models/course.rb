# == Schema Information
#
# Table name: courses
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  prereq_id     :integer
#  instructor_id :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class Course < ActiveRecord::Base
  has_many :enrollments,
    class_name: "Enrollment",
    foreign_key: :course_id,
    primary_key: :id

  belongs_to :prereq,
    class_name: "Course",
    foreign_key: :prereq_id,
    primary_key: :id

  belongs_to :instructor,
    class_name: "User",
    foreign_key: :instructor_id,
    primary_key: :id

  has_many :students, :through => :enrollments, :source => :user

  # has_many :prerequisites, :through => :course, :source => :course

  def enrolled_students
    self.students
  end

  # def prereq
  #   self.prerequisite
  # end
end
