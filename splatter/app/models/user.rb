class User < Hashie::Dash

property :email
property :name
property :password
property :blurb
property :follows
property :followers












#validates :name, presence: true
#validates :email, uniqueness: {case_sensitive: false}
#validates :password, length: {minimum: 8}, if: :strong?


#def strong?
 # password =~ /.*\d+.*/ && \
  #password =~ /.*[a-z]+.*/ && \
  #password =~ /.*[A-Z]+.*/
#end

end

