postgres:
	docker run --name postgres5 -e POSTGRES_USER=admin -e POSTGRES_PASSWORD=admin -d -p 5432:5432 postgres:14-alpine

createdb:
	docker exec -it postgres5 createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it postgres5 dropdb simple_bank

migrateup:
	migrate -path db/migration -database "postgresql://@localhost:5432/simple_bank?sslmode=disable" -verbose up

migrateup1:
	migrate -path db/migration -database "postgresql://@localhost:5432/simple_bank?sslmode=disable" -verbose up 1

migratedown:
	migrate -path db/migration -database "postgresql://@localhost:5432/simple_bank?sslmode=disable" -verbose down

migratedown1:
	migrate -path db/migration -database "postgresql://@localhost:5432/simple_bank?sslmode=disable" -verbose down

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

server:
	go run main.go

mock:
	mockgen -package mockdb -destination db/mock/store.go github.com/neuthos/go-simplebank/db/sqlc Store

.PHONY: postgres createdb dropdb migrateup migratedown migrateup1 migratedown1 sqlc test server mock