import { PrismaClient } from '@prisma/client'
const prisma = new PrismaClient()

async function main(){
	// const user = await prisma.user.create({data:{name:"bini"}})
	await prisma.user.deleteMany()
	// every time we save we are deleting the user then we are saving the file 
	const user = await prisma.user.create({
		data:{
			name:"yafet",
			email:"yafet123@gmail.com",
			age:24,
			userPreferences:{
				create:{
					emailUpdates:true
				}
			}
		},
		// include:{
		// 	userPreferences:true,
		// },
		select:{
			name:true,
			userPreferences:true
		}
	})
	console.log(user)
}

// we will qrite our prisma code in the main then it will catch the error message
// in the catch and display or console the error and if it is over it will disconnect
// at finally we can remove it because prisma disconnect as soon as we finish.

main().catch(e=>{
	console.log(e.message)
}).finally(async ()=>{
	await prisma.$disconnect()
})