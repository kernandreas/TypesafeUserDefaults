# TypesafeUserDefaults

[![Build Status](https://travis-ci.org/kernandreas/TypesafeUserDefaults.svg?branch=master)](https://travis-ci.org/kernandreas/TypesafeUserDefaults)

TypesafeUserDefaults is a thin extension to UserDefaults that enables a type safe use. As a bonus, Types that conform to Codable can be stored in the UserDefaults.

# Motivation 
The UserDefaults API in Foundation uses since ever Strings as keys. This is error prone and can lead to bugs. A good habit is to define static Strings. 