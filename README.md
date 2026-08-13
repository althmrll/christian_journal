# README

Preparatory:
- Install Ruby 3.2.6 on your machine
- Install postgresql on your machine

Steps to Initialize website
Step 1: Clone repository

Step 2: in you terminal type "bundle install" and wait for the installation to finish

Step 3: after installation finishes type "bin/rails db:prepare" to initialize databases for the website

Step 4: go to rails console using "bin/rails console" to create your password. Use Access.create!(password: "PASSWORD")

Step 5: Exit console

Step 6: type "bin/dev". this will automatically install foreman and run the website

Step 7: Access "http://localhost:3000/" in your browser to view and use website