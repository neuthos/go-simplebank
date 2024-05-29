package simple_bank

import (
	"database/sql"
	"log"
	"os"
	"testing"

	"github.com/neuthos/go-simplebank/util"

	_ "github.com/lib/pq"
)



var testStore *Queries
var testDb *sql.DB

func TestMain(m *testing.M) {
	config, err := util.LoadConfig("../..")
	if err != nil {
		log.Fatal("cannot load config:", err)
	}

	testDb, err = sql.Open(config.DBDriver, config.DBSource)

	if err != nil {
		log.Fatal("cannot connect to db:", err)
	}

	testStore = New(testDb)
	os.Exit(m.Run())
}