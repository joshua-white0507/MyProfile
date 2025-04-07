require 'faker'

# Clear existing data
User.destroy_all

# Define options for fields
practices = [
  'Business Consulting', 'Technology Consulting', 'Design Practice',
  'Delivery Consulting', 'Service Centre', 'Quality Engineering',
  'Operations and Finance', 'Software Engineering', 'Other'
]

grades = (1..9).to_a

skills = [
  'Ruby', 'JavaScript', 'Python', 'Java', 'C++', 'HTML', 'CSS', 'SQL'
]

soft_skills = [
  'Presentations', 'Stakeholder Management', 'Team Leadership',
  'Time Management', 'Problem Solving'
]

previous_clients = [
  'Mitsubishi', 'Barclays', 'Santander', 'Westfield', 'FIFA', 'F1',
  'NHS', 'British Museum', 'Other'
]

interests = [
  'Construction', 'Healthcare', 'Education', 'Manufacturing',
  'Entertainment', 'Retail', 'Financial services', 'Other'
]

experience_templates = [
  "Over 5 years of experience in %{practice}, specializing in %{skills}.",
  "Proven track record of delivering successful projects in %{practice} with expertise in %{skills}.",
  "Highly skilled in %{skills} with a strong background in %{practice}.",
  "Experienced professional with a focus on %{practice} and a passion for %{interest}.",
  "Dedicated to achieving excellence in %{practice}, with hands-on experience in %{skills}."
]

# Path to sample photos
photo_directory = Rails.root.join('db', 'seeds', 'photos')
photo_files = Dir.exist?(photo_directory) ? Dir.children(photo_directory) : [] # Get all photo filenames if the directory exists

# Fallback photo
fallback_photo = photo_directory.join('photo31.png')

# Create an admin user
admin_user = User.create!(
  email: "admin@example.com",
  password: "password",
  password_confirmation: "password",
  admin: true,
  name: "Admin User",
  practice: practices.sample,
  grade: grades.sample,
  bench: false,
  skills: skills.sample(3),
  previous_clients: previous_clients.sample(2),
  interest: interests.sample,
  experience: "Experienced admin user with a strong background in managing systems and users."
)

# Attach a photo to the admin user
admin_user.profile_photo.attach(
  io: File.open(photo_files.any? ? photo_directory.join(photo_files.sample) : fallback_photo),
  filename: "admin_photo.jpg"
)

# Create normal users
50.times do |i|
  full_name = Faker::Name.name
  first_name = full_name.split.first.downcase # Extract the first name and make it lowercase
  unique_email = "#{first_name}#{i}@solirius.com" # Append a unique number to ensure uniqueness

  user = User.create!(
    email: unique_email, # Use the unique email
    password: "password",
    password_confirmation: "password",
    admin: false,
    name: full_name,
    practice: practices.sample,
    grade: grades.sample,
    bench: Faker::Boolean.boolean,
    skills: skills.sample(3) + soft_skills.sample(2),
    previous_clients: previous_clients.sample(rand(0..3)),
    interest: interests.sample,
    experience: experience_templates.sample % {
      practice: practices.sample,
      skills: skills.sample(3).join(", "),
      interest: interests.sample
    }
  )

  # Attach a random photo or fallback photo to the user
  user.profile_photo.attach(
    io: File.open(photo_files.any? ? photo_directory.join(photo_files.sample) : fallback_photo),
    filename: "photo#{i}.png"
  )
end

puts "Seeded #{User.count} users with photos."