/*
  Warnings:

  - The primary key for the `user` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - A unique constraint covering the columns `[userPreferencesid]` on the table `user` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[age,name]` on the table `user` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `age` to the `user` table without a default value. This is not possible if the table is not empty.
  - Added the required column `email` to the `user` table without a default value. This is not possible if the table is not empty.
  - Added the required column `userPreferencesid` to the `user` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "Role" AS ENUM ('BASIC', 'ADMIN');

-- AlterTable
ALTER TABLE "user" DROP CONSTRAINT "user_pkey",
ADD COLUMN     "age" INTEGER NOT NULL,
ADD COLUMN     "email" TEXT NOT NULL,
ADD COLUMN     "role" "Role" NOT NULL DEFAULT 'BASIC',
ADD COLUMN     "userPreferencesid" TEXT NOT NULL,
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ADD CONSTRAINT "user_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "user_id_seq";

-- CreateTable
CREATE TABLE "userPreferences" (
    "id" TEXT NOT NULL,
    "emailUpdates" BOOLEAN NOT NULL,

    CONSTRAINT "userPreferences_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Post" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "rating" DOUBLE PRECISION NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "authorid" TEXT NOT NULL,
    "favouriteByid" TEXT,

    CONSTRAINT "Post_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "category" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "category_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_PostTocategory" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "_PostTocategory_AB_unique" ON "_PostTocategory"("A", "B");

-- CreateIndex
CREATE INDEX "_PostTocategory_B_index" ON "_PostTocategory"("B");

-- CreateIndex
CREATE UNIQUE INDEX "user_userPreferencesid_key" ON "user"("userPreferencesid");

-- CreateIndex
CREATE INDEX "user_email_idx" ON "user"("email");

-- CreateIndex
CREATE UNIQUE INDEX "user_age_name_key" ON "user"("age", "name");

-- AddForeignKey
ALTER TABLE "user" ADD CONSTRAINT "user_userPreferencesid_fkey" FOREIGN KEY ("userPreferencesid") REFERENCES "userPreferences"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Post" ADD CONSTRAINT "Post_authorid_fkey" FOREIGN KEY ("authorid") REFERENCES "user"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Post" ADD CONSTRAINT "Post_favouriteByid_fkey" FOREIGN KEY ("favouriteByid") REFERENCES "user"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_PostTocategory" ADD CONSTRAINT "_PostTocategory_A_fkey" FOREIGN KEY ("A") REFERENCES "Post"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_PostTocategory" ADD CONSTRAINT "_PostTocategory_B_fkey" FOREIGN KEY ("B") REFERENCES "category"("id") ON DELETE CASCADE ON UPDATE CASCADE;
