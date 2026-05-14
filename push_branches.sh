#!/bin/bash
set -e

BASE=/home/kashmira/Downloads/BikeRentalSystem/src/main/java/com/bikerental/BikeRentalSystem
MAIN_BRANCH=main

copy_and_push() {
  local branch=$1
  shift
  local files=("$@")

  git checkout $branch

  for file in "${files[@]}"; do
    # find the file in main and copy to same relative path in this branch
    src=$(git show $MAIN_BRANCH:$(git ls-tree -r $MAIN_BRANCH --name-only | grep "/$file$"))
    path=$(git ls-tree -r $MAIN_BRANCH --name-only | grep "/$file$")
    git checkout $MAIN_BRANCH -- "$path"
  done

  git add .
  git commit -m "Update $branch with latest Java files from main" || echo "Nothing to commit on $branch"
  git push origin $branch --force
}

copy_and_push "bike-management" \
  "Bike.java" "ElectricBike.java" "MountainBike.java" "RoadBike.java" "BikeService.java" "BikeServlet.java"

copy_and_push "user-management" \
  "User.java" "AdminUser.java" "RegularUser.java" "UserService.java" "UserServlet.java"

copy_and_push "rental-management" \
  "Rental.java" "HourlyRental.java" "DailyRental.java" "RentalService.java" "RentalServlet.java"

copy_and_push "payment-management" \
  "Payment.java" "CardPayment.java" "CashPayment.java" "PaymentService.java" "PaymentServlet.java"

copy_and_push "review-management" \
  "Review.java" "BikeReview.java" "ServiceReview.java" "ReviewService.java" "ReviewServlet.java"

copy_and_push "station-management" \
  "Station.java" "MainStation.java" "SatelliteStation.java" "StationService.java" "StationServlet.java"

git checkout main
echo "All done!"
