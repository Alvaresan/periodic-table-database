#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]
then
  echo -e "Please provide an element as an argument."
elif [[ $1 ]]
then
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number=$1;")
    if [[ -z $ATOMIC_NUMBER ]]
    then
      echo -e "I could not find that element in the database."
    else
      VAR=$($PSQL "SELECT * FROM elements INNER JOIN properties USING (atomic_number) INNER JOIN types USING (type_id) WHERE atomic_number=$1;")
      echo "$VAR" | while IFS='|' read TYPE_ID ATO_NUM SYMBOL NAME MASS MELTING BOILING TYPE
      do
        echo -e "The element with atomic number $ATO_NUM is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
      done
    fi
  elif [[ $1 =~ ^[A-Z][a-z]{0,2}$ ]]
  then
    SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE symbol='$1';")
    if [[ -z $SYMBOL ]]
    then
      echo -e "I could not find that element in the database."
    else
      VAR=$($PSQL "SELECT * FROM elements INNER JOIN properties USING (atomic_number) INNER JOIN types USING (type_id) WHERE symbol='$1';")
      echo "$VAR" | while IFS='|' read TYPE_ID ATO_NUM SYMBOL NAME MASS MELTING BOILING TYPE
      do
        echo -e "The element with atomic number $ATO_NUM is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
      done
    fi
  else
    NAME=$($PSQL "SELECT name FROM elements WHERE name='$1';")
    if [[ -z $NAME ]]
    then
      echo -e "I could not find that element in the database."
    else
      VAR=$($PSQL "SELECT * FROM elements INNER JOIN properties USING (atomic_number) INNER JOIN types USING (type_id) WHERE name='$1';")
      echo "$VAR" | while IFS='|' read TYPE_ID ATO_NUM SYMBOL NAME MASS MELTING BOILING TYPE
      do
        echo -e "The element with atomic number $ATO_NUM is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
      done
    fi
  fi
fi