class User < ActiveRecord::Base
  has_many :sent_messages, :class_name => 'Message', :foreign_key => 'sender_id'
  has_many :received_messages, :class_name => 'Message', :foreign_key => 'recipient_id'
  has_secure_password
  email_regex = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :f_name, :presence => {message:["first name cant be blank"]}
  validates :l_name,:password, :presence => {message:["last name cant be blank"]}
  validates :password, :presence => {message:["password cant be blank"]}
  validates :email, :presence => true, :format => { :with => email_regex}, :uniqueness => { :case_sensitive => false}
end
