-- DropForeignKey
ALTER TABLE "user" DROP CONSTRAINT "user_userPreferencesid_fkey";

-- AlterTable
ALTER TABLE "user" ALTER COLUMN "userPreferencesid" DROP NOT NULL;

-- AddForeignKey
ALTER TABLE "user" ADD CONSTRAINT "user_userPreferencesid_fkey" FOREIGN KEY ("userPreferencesid") REFERENCES "userPreferences"("id") ON DELETE SET NULL ON UPDATE CASCADE;
