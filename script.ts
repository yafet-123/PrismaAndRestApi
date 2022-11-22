import { PrismaClient } from '@prisma/client'
const prisma = new PrismaClient({log:["query"]})

async function main(){
	// const user = await prisma.user.create({data:{name:"bini"}})
	// await prisma.user.deleteMany()
	// await prisma.userPreferences.deleteMany()
	// every time we save we are deleting the user then we are saving the file 
	// const user = await prisma.user.create({
	// 	data:{
	// 		name:"yafet",
	// 		email:"yafet123@gmail.com",
	// 		age:24,
	// 		userPreferences:{
	// 			create:{
	// 				emailUpdates:true
	// 			}
	// 		}
	// 	},
	// 	// include:{
	// 	// 	userPreferences:true,
	// 	// },
	// 	select:{
	// 		name:true,
	// 		userPreferences:{select:{
	// 			id:true
	// 		}}
	// 	}
	// 	// return the user name and the userprefences
	// })

	const user = await prisma.user.findMany({
		where:{
			// email:"yafet123@gmail.com",
			// age_name:{
			// 	age:24,
			// 	name:"yafet"
			// } this is for composite key
			name:"yafet"
		},
		// distinct:["name"]
		// take:2
		skip:1
	})

	// const user = await prisma.user.createMany({
	// 	data:[
	// 		{
	// 			name:"yafet",
	// 			email:"yafet1@gmail.com",
	// 			age:25,
	// 		},
	// 		{
	// 			name:"yafet",
	// 			email:"yafet2@gmail.com",
	// 			age:16,

	// 		},
	// 		{
	// 			name:"yafet",
	// 			email:"yafet3@gmail.com",
	// 			age:19,

	// 		},
	// 	],
			
	// })
	console.log(user)

	// const userpre = await prisma.userPreferences.findMany()
	// console.log(userpre)
}

// we will qrite our prisma code in the main then it will catch the error message
// in the catch and display or console the error and if it is over it will disconnect
// at finally we can remove it because prisma disconnect as soon as we finish.

main().catch(e=>{
	console.log(e.message)
}).finally(async ()=>{
	await prisma.$disconnect()
})