const express = require("express");
const admin = require("../middleware/admin");
const adminRouter = express.Router();
const { Product } = require('../model/product')
const Order = require("../model/order");

//
adminRouter.post('/admin/add-product', admin, async (req, res) => {
    try {
        const { name, description, images, quantity, price, category } = req.body
        let product = new Product({
            name,
            description,
            images,
            category,
            quantity,
            price
        });
        product = await product.save();
        res.json(product)

    } catch (error) {
        res.status(500).json({ error: error.message });

    }

});

adminRouter.get('/admin/get-products', admin, async (req, res) => {
    try {
        const products = await Product.find({});
        res.json(products);

    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

adminRouter.post('/admin/deleteproduct', admin, async (req, res) => {
    try {
        const { id } = req.body;
        const product = await Product.findByIdAndDelete(id);

        res.json(product)
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
})

// get all Orders
adminRouter.get('/admin/get-orders', admin, async (req, res) => {
    try {
        const orders = await Order.find({});
        res.json(orders);

    } catch (error) {
        res.status(500).json({ error: error.message });
    }

})

adminRouter.post('/admin/change-order-status', admin, async (req, res) => {
    try {
        const { id, status } = req.body;
        const updatedOrder = await updateOrderStatus(id, status);
        res.json(updatedOrder);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

async function updateOrderStatus(id, status) {
    try {
        const updatedOrder = await Order.findByIdAndUpdate(id, { status }, { new: true });
        return updatedOrder;
    } catch (error) {
        throw new Error(`Failed to update order status: ${error.message}`);
    }
}


adminRouter.get('/admin/analytics', admin, async (req, res) => {
    try {
        const orders = await Order.find({});
        let totalEarnings = 0;

        for (let i = 0; i < orders.length; i++) {
            for (let j = 0; j < orders[i].products.length; j++) {
                totalEarnings += orders[i].products[j].quantity * orders[i].products[j].price;
            };

        }
        const numOfOrders = orders.length;

        let mobilesEarning = await fetchCategoryWiseProductAnalytics('Mobiles');
        let essentialsEarning = await fetchCategoryWiseProductAnalytics('Essentials');
        let appliancesEarning = await fetchCategoryWiseProductAnalytics('Appliances');
        let booksEarning = await fetchCategoryWiseProductAnalytics('Books');
        let fashionEarning = await fetchCategoryWiseProductAnalytics('Fashion');
        let earnings = {
            numOfOrders,
            totalEarnings,
            mobilesEarning,
            essentialsEarning,
            appliancesEarning,
            booksEarning,
            fashionEarning
        }



        res.json(earnings);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }


})

async function fetchCategoryWiseProductAnalytics(category) {
    try {
        const categoryOrdersProducts = await Order.find({ "products.product.category": category });
        let totalEarnings = 0;

        for (let i = 0; i < categoryOrdersProducts.length; i++) {
            for (let j = 0; j < categoryOrdersProducts[i].products.length; j++) {
                totalEarnings += categoryOrdersProducts[i].products[j].quantity * categoryOrdersProducts[i].products[j].price;
            }
        }

        return totalEarnings;
    } catch (error) {
        throw new Error(`Failed to fetch category wise product analytics: ${error.message}`);
    }
}





module.exports = adminRouter;