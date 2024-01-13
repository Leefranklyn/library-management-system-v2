-- CreateEnum
CREATE TYPE "BookCategory" AS ENUM ('Fiction', 'NonFiction', 'Mystery', 'Romance', 'ScienceFiction', 'Fantasy', 'Biography', 'SelfHelp', 'History', 'Thriller', 'Horror', 'Poetry', 'Business', 'Travel', 'Cookbooks', 'Science', 'Technology', 'HealthAndWellness', 'ChildrensBooks', 'YoungAdult');

-- CreateEnum
CREATE TYPE "BookStatus" AS ENUM ('IN_SHELF', 'BORROWED');

-- CreateEnum
CREATE TYPE "PaymentStatus" AS ENUM ('NONE', 'PENDING', 'ACCEPTED');

-- CreateTable
CREATE TABLE "Admin" (
    "id" SERIAL NOT NULL,
    "fullName" TEXT NOT NULL DEFAULT 'John Doe',
    "profilePhoto" TEXT DEFAULT 'https://img.freepik.com/premium-vector/man-avatar-profile-picture-vector-illustration_268834-538.jpg',
    "regNo" TEXT NOT NULL,
    "phoneNumber" TEXT DEFAULT '',
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "about" TEXT DEFAULT '',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Admin_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "User" (
    "id" SERIAL NOT NULL,
    "fullName" TEXT NOT NULL DEFAULT 'John Doe',
    "profilePhoto" TEXT DEFAULT 'https://img.freepik.com/premium-vector/man-avatar-profile-picture-vector-illustration_268834-538.jpg',
    "regNo" TEXT NOT NULL,
    "phoneNumber" TEXT DEFAULT '',
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "about" TEXT DEFAULT '',
    "disabled" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Book" (
    "id" SERIAL NOT NULL,
    "bookName" TEXT NOT NULL,
    "authorName" TEXT NOT NULL,
    "about" TEXT DEFAULT '',
    "isbn" TEXT NOT NULL,
    "eBook" TEXT DEFAULT '',
    "audioBook" TEXT DEFAULT '',
    "converImage" TEXT NOT NULL,
    "category" "BookCategory" NOT NULL,
    "hardCopyFormat" BOOLEAN DEFAULT false,
    "eBookFormat" BOOLEAN DEFAULT false,
    "audioBookFormat" BOOLEAN DEFAULT false,
    "status" "BookStatus" NOT NULL DEFAULT 'IN_SHELF',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Book_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Borrow" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "bookId" INTEGER NOT NULL,
    "bookName" TEXT NOT NULL,
    "isbn" TEXT NOT NULL,
    "borrowDate" TIMESTAMP(3) NOT NULL,
    "returnDate" TIMESTAMP(3) NOT NULL,
    "fine" INTEGER NOT NULL DEFAULT 0,
    "paymentStatus" "PaymentStatus" NOT NULL DEFAULT 'NONE',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Borrow_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Admin_regNo_key" ON "Admin"("regNo");

-- CreateIndex
CREATE UNIQUE INDEX "Admin_email_key" ON "Admin"("email");

-- CreateIndex
CREATE UNIQUE INDEX "User_regNo_key" ON "User"("regNo");

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Book_isbn_key" ON "Book"("isbn");

-- AddForeignKey
ALTER TABLE "Borrow" ADD CONSTRAINT "Borrow_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Borrow" ADD CONSTRAINT "Borrow_bookId_fkey" FOREIGN KEY ("bookId") REFERENCES "Book"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
